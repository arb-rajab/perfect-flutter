import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/path/shared.dart';
import 'package:beta/application/services/term_service.dart';
import 'package:beta/configs/links.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/deep_link_target.dart';
import 'package:beta/domain/question_uuid.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/title.dart' as t;
import 'package:beta/infrastructure/url_launcher_repository.dart';
import 'package:beta/presentation/contact_us/contact_us_screen.dart';
import 'package:beta/presentation/ebook/ebook_screen.dart';
import 'package:beta/presentation/enter_coupon/enter_coupon_screen.dart';
import 'package:beta/presentation/flashcards/flashcards_screen.dart';
import 'package:beta/presentation/frequent_questions/frequent_questions_screen.dart';
import 'package:beta/presentation/home/home_screen.dart';
import 'package:beta/presentation/images/images_screen.dart';
import 'package:beta/presentation/news/news_screen.dart';
import 'package:beta/presentation/questions/questions_screen.dart';
import 'package:beta/presentation/splash/splash_screen.dart';
import 'package:beta/presentation/video_file/video_file_screen.dart';
import 'package:beta/presentation/voice_note/voice_note_screen.dart';
import 'package:drift/drift.dart';
import 'package:get/instance_manager.dart';

enum DeepLinkOutcome {
  /// The content opens at [DeepLinkResolution.location], or the home screen
  /// when there is no location (e.g. a folder term).
  opened,

  /// The term or one of its ancestors is disabled.
  locked,

  /// No active coupon covers the term: it expired or was never bought.
  expired,

  /// The content is not on this device (deleted, or never downloaded).
  unavailable,

  /// The term exists but its content has not been downloaded yet.
  notDownloaded,
}

class DeepLinkResolution {
  final DeepLinkOutcome outcome;

  /// Route to open on top of the home screen, if any.
  final String? location;

  const DeepLinkResolution(this.outcome, [this.location]);

  @override
  String toString() => 'DeepLinkResolution($outcome, $location)';
}

/// Checks whether content can be opened, without navigating, so the
/// assistant can check a link in its background engine too.
class ContentAccessService {
  final DatabaseService databaseService;

  ContentAccessService({required this.databaseService});

  /// Whether [target] can be opened now. Unlike [DeepLinkService.resolve],
  /// it does not check that the content was downloaded.
  Future<DeepLinkOutcome> check(DeepLinkTarget target) async {
    final int? termId;
    switch (target.type) {
      case AssistantContentType.term:
      case AssistantContentType.ebook:
        termId = target.id;
      case AssistantContentType.question:
        termId = await _parentTermId('questions', target.id);
      case AssistantContentType.flashcard:
        termId = await _parentTermId('flashcards', target.id);
      case AssistantContentType.faq:
      case AssistantContentType.news:
        // Public content.
        return DeepLinkOutcome.opened;
    }
    if (termId == null) return DeepLinkOutcome.unavailable;
    return (await checkTerm(termId))?.outcome ?? DeepLinkOutcome.opened;
  }

  /// Returns why [termId] cannot be opened, or null when it is unlocked.
  Future<DeepLinkResolution?> checkTerm(int termId) async {
    final row = await databaseService
        .customSelect(
          'select ${TermService.enabledTermCondition} as enabled, '
          '${TermService.unExpiredTermCondition} as unExpired '
          'from terms t where t.id=?',
          variables: [Variable.withInt(termId)],
        )
        .getSingleOrNull();
    if (row == null) {
      return const DeepLinkResolution(DeepLinkOutcome.unavailable);
    }
    if (row.read<int>('enabled') != 1) {
      return const DeepLinkResolution(DeepLinkOutcome.locked);
    }
    if (row.read<int>('unExpired') != 1) {
      return const DeepLinkResolution(
        DeepLinkOutcome.expired,
        EnterCouponScreen.route,
      );
    }
    return null;
  }

  Future<int?> _parentTermId(String table, int id) async =>
      (await databaseService
              .customSelect(
                'select parentTermId from $table where id=?',
                variables: [Variable.withInt(id)],
              )
              .getSingleOrNull())
          ?.read<int>('parentTermId');
}

/// Resolves content deep links to routes, checking access at the time the
/// link is opened: content found by a search can be locked by then.
///
/// Like the rest of the app, the opened screen reads its argument with
/// `Get.find`, so [resolve] registers it before returning the route.
class DeepLinkService {
  final DatabaseService databaseService;
  final TermService termService;
  final PathService pathService;
  final ContentAccessService _access;

  DeepLinkService({
    required this.databaseService,
    required this.termService,
    required this.pathService,
  }) : _access = ContentAccessService(databaseService: databaseService);

  Future<DeepLinkResolution> resolve(DeepLinkTarget target) {
    switch (target.type) {
      case AssistantContentType.term:
        return _resolveTerm(target.id);
      case AssistantContentType.ebook:
        return _resolveTerm(target.id, requiredType: TermType.ebook);
      case AssistantContentType.question:
        return _resolveQuestion(target.id);
      case AssistantContentType.flashcard:
        return _resolveFlashcard(target.id);
      case AssistantContentType.faq:
        return Future.value(
          DeepLinkResolution(
            DeepLinkOutcome.opened,
            '${FrequentQuestionsScreen.route}?id=${target.id}',
          ),
        );
      case AssistantContentType.news:
        return Future.value(
          DeepLinkResolution(
            DeepLinkOutcome.opened,
            NewsScreen.route.replaceFirst(':newsId', target.id.toString()),
          ),
        );
    }
  }

  /// Resolves a `/q/<uuid>` share link. A uuid that is not on this device is
  /// let through so the questions screen can download it, and checks again.
  Future<DeepLinkResolution> resolveQuestionUuid(String uuid) async {
    if (!isQuestionUuid(uuid)) {
      return const DeepLinkResolution(DeepLinkOutcome.unavailable);
    }
    final question = await (databaseService.select(
      databaseService.questions,
    )..where((tbl) => tbl.uuid.equals(uuid))).getSingleOrNull();
    final denied = question == null
        ? null
        : await _access.checkTerm(question.parentTermId);
    return denied ??
        DeepLinkResolution(
          DeepLinkOutcome.opened,
          QuestionsScreen.uuidRoute.replaceFirst(':uuid', uuid),
        );
  }

  Future<DeepLinkResolution> _resolveTerm(
    int termId, {
    int? requiredType,
  }) async {
    final denied = await _access.checkTerm(termId);
    if (denied != null) return denied;
    final termData = await termService.getTermDataById(termId);
    if (termData == null ||
        (requiredType != null && termData.term.type != requiredType)) {
      return const DeepLinkResolution(DeepLinkOutcome.unavailable);
    }
    return _openTermContent(termData);
  }

  /// Mirrors `TermWidgetController`'s handling of a tap on a term.
  Future<DeepLinkResolution> _openTermContent(TermData termData) async {
    final int termId = termData.term.id;
    const notDownloaded = DeepLinkResolution(DeepLinkOutcome.notDownloaded);
    switch (termData.term.type) {
      case TermType.questions:
      case TermType.template:
        if ((termData.numberOfQuestions?.value ?? 0) == 0) return notDownloaded;
        _putQuestionsArgument(termData);
        return const DeepLinkResolution(
          DeepLinkOutcome.opened,
          QuestionsScreen.route,
        );
      case TermType.flashcards:
        if ((termData.numberOfFlashcards?.value ?? 0) == 0) {
          return notDownloaded;
        }
        _putFlashcardsArgument(termData);
        return const DeepLinkResolution(
          DeepLinkOutcome.opened,
          FlashcardsScreen.route,
        );
      case TermType.images:
        if ((termData.numberOfImages?.value ?? 0) == 0) return notDownloaded;
        await Get.delete<ImagesScreenArgument>();
        Get.put(
          ImagesScreenArgument(
            query: 'select * from images where parentTermId=$termId',
            title: termData.term.name,
            term: termData,
          ),
        );
        return const DeepLinkResolution(
          DeepLinkOutcome.opened,
          ImagesScreen.route,
        );
      case TermType.ebook:
      case TermType.voiceNotes:
      case TermType.videoFile:
        if (!await pathService.isFilePartsInSupport([
          'term',
          termId.toString(),
        ])) {
          return notDownloaded;
        }
        return DeepLinkResolution(
          DeepLinkOutcome.opened,
          await _putFileArgument(termData),
        );
      default:
        // Folders and YouTube videos open from the home screen.
        return const DeepLinkResolution(DeepLinkOutcome.opened);
    }
  }

  Future<String> _putFileArgument(TermData termData) async {
    switch (termData.term.type) {
      case TermType.ebook:
        await Get.delete<EbookScreenArgument>();
        Get.put(EbookScreenArgument(term: termData));
        return EbookScreen.route;
      case TermType.voiceNotes:
        await Get.delete<VoiceNoteScreenArgument>();
        Get.put(VoiceNoteScreenArgument(term: termData));
        return VoiceNoteScreen.route;
      default:
        await Get.delete<VideoFileScreenArgument>();
        Get.put(VideoFileScreenArgument(term: termData));
        return VideoFileScreen.route;
    }
  }

  void _putQuestionsArgument(TermData termData) {
    Get.delete<QuestionsScreenArgument>();
    Get.put(
      QuestionsScreenArgument(
        query: "q.parentTermId= '${termData.term.id}' ORDER BY q.id asc",
        source: QuestionScreenSource.term,
        sourceId: Id(termData.term.id),
        resourceTermId: Id(termData.term.id),
        title: t.Title(termData.term.name),
        termData: termData,
      ),
    );
  }

  void _putFlashcardsArgument(TermData termData, {int? initialFlashcardId}) {
    Get.delete<FlashcardsScreenArgument>();
    Get.put(
      FlashcardsScreenArgument(
        query:
            'select * from flashcards where parentTermId=${termData.term.id}',
        title: termData.term.name,
        term: termData,
        initialFlashcardId: initialFlashcardId,
      ),
    );
  }

  Future<DeepLinkResolution> _resolveQuestion(int questionId) async {
    final question = await (databaseService.select(
      databaseService.questions,
    )..where((tbl) => tbl.id.equals(questionId))).getSingleOrNull();
    if (question == null) {
      return const DeepLinkResolution(DeepLinkOutcome.unavailable);
    }
    final denied = await _access.checkTerm(question.parentTermId);
    if (denied != null) return denied;
    if (question.uuid.isNotEmpty) {
      // The uuid route opens the question's term scrolled to the question.
      return DeepLinkResolution(
        DeepLinkOutcome.opened,
        QuestionsScreen.uuidRoute.replaceFirst(
          ':uuid',
          Uri.encodeComponent(question.uuid),
        ),
      );
    }
    final termData = await termService.getTermDataById(question.parentTermId);
    if (termData == null) {
      return const DeepLinkResolution(DeepLinkOutcome.unavailable);
    }
    _putQuestionsArgument(termData);
    return const DeepLinkResolution(
      DeepLinkOutcome.opened,
      QuestionsScreen.route,
    );
  }

  Future<DeepLinkResolution> _resolveFlashcard(int flashcardId) async {
    final flashcard = await (databaseService.select(
      databaseService.flashcards,
    )..where((tbl) => tbl.id.equals(flashcardId))).getSingleOrNull();
    if (flashcard == null) {
      return const DeepLinkResolution(DeepLinkOutcome.unavailable);
    }
    final denied = await _access.checkTerm(flashcard.parentTermId);
    if (denied != null) return denied;
    final termData = await termService.getTermDataById(flashcard.parentTermId);
    if (termData == null) {
      return const DeepLinkResolution(DeepLinkOutcome.unavailable);
    }
    _putFlashcardsArgument(termData, initialFlashcardId: flashcardId);
    return const DeepLinkResolution(
      DeepLinkOutcome.opened,
      FlashcardsScreen.route,
    );
  }
}

/// The navigation [DeepLinkCoordinator] needs from the app's router.
abstract class DeepLinkNavigator {
  /// Completes once the router can navigate (after the first frame).
  Future<void> get ready;

  String get currentLocation;

  Future<void> go(String location);

  Future<void> push(String location);

  /// Shows the translated [messageKey]; [onConfirm] runs when dismissed.
  Future<void> showMessage(String messageKey, {void Function()? onConfirm});
}

/// Opens incoming links, on cold start (the app was launched by the link)
/// and warm start (the app was already running).
class DeepLinkCoordinator {
  /// app_links delivers the launch link both from getInitialLink and from
  /// uriLinkStream, so the same link arriving twice within this window is
  /// opened once.
  static const Duration duplicateWindow = Duration(seconds: 2);

  /// Routes of the `perfect://<section>` links that the Android app
  /// shortcuts open (android/app/src/main/res/xml/shortcuts.xml).
  static const Map<String, String> sectionRoutes = {
    'coupon': EnterCouponScreen.route,
    'faq': FrequentQuestionsScreen.route,
    'contact': ContactUsScreen.route,
  };

  final DeepLinkService deepLinkService;
  final DeepLinkNavigator navigator;
  final DateTime Function() _now;

  Uri? _lastUri;
  DateTime? _lastHandledAt;

  DeepLinkCoordinator({
    required this.deepLinkService,
    required this.navigator,
    DateTime Function()? now,
  }) : _now = now ?? DateTime.now;

  Future<void> handle(Uri uri) async {
    final now = _now();
    if (uri == _lastUri &&
        _lastHandledAt != null &&
        now.difference(_lastHandledAt!) < duplicateWindow) {
      return;
    }
    _lastUri = uri;
    _lastHandledAt = now;

    await navigator.ready;
    final target = DeepLinkTarget.parse(uri);
    if (target == null) {
      final section = _sectionRoute(uri);
      if (section != null) {
        await _openOverHome(section);
        return;
      }
      final questionUuid = _questionUuid(uri);
      if (questionUuid != null) {
        await present(await deepLinkService.resolveQuestionUuid(questionUuid));
        return;
      }
      // Other app links keep their route.
      final isAppRoute =
          uri.scheme.toLowerCase() != DeepLinkTarget.scheme &&
          uri.path.isNotEmpty;
      await navigator.go(isAppRoute ? uri.path : HomeScreen.route);
      return;
    }
    await present(await deepLinkService.resolve(target));
  }

  /// Opens a link that cannot be opened (the questions screen found out
  /// after it was shown) from the home screen.
  Future<void> showDenied(DeepLinkResolution resolution) async {
    await navigator.go(HomeScreen.route);
    await present(resolution);
  }

  Future<void> present(DeepLinkResolution resolution) async {
    await _openOverHome(resolution.location);
    switch (resolution.outcome) {
      case DeepLinkOutcome.opened:
        break;
      case DeepLinkOutcome.locked:
        await navigator.showMessage(
          StringConstant.contentLocked,
          onConfirm: () =>
              Get.find<UrlLauncherRepository>().openUrl(telegramChannelLink),
        );
      case DeepLinkOutcome.expired:
        await navigator.showMessage(StringConstant.termIsExpired);
      case DeepLinkOutcome.unavailable:
        await navigator.showMessage(StringConstant.contentUnavailable);
      case DeepLinkOutcome.notDownloaded:
        await navigator.showMessage(StringConstant.youHaveToDownloadFirst);
    }
  }

  /// Opens [location], if any, on top of the current screen.
  Future<void> _openOverHome(String? location) async {
    // On cold start the splash screen is showing; put the home screen under
    // the content so that back leads into the app instead of out of it.
    if (navigator.currentLocation == SplashScreen.route) {
      await navigator.go(HomeScreen.route);
    }
    if (location != null) await navigator.push(location);
  }

  /// The uuid of a `/q/<uuid>` question share link; null for other links.
  static String? _questionUuid(Uri uri) {
    final segments = uri.pathSegments;
    if (segments.length != 2 || segments[0] != 'q') return null;
    final scheme = uri.scheme.toLowerCase();
    if (scheme == DeepLinkTarget.scheme) return null;
    return segments[1];
  }

  static String? _sectionRoute(Uri uri) {
    if (uri.scheme.toLowerCase() != DeepLinkTarget.scheme) return null;
    if (uri.pathSegments.any((s) => s.isNotEmpty)) return null;
    return sectionRoutes[uri.host.toLowerCase()];
  }
}
