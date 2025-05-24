import 'package:audio_service/audio_service.dart';
import 'package:beta/application/services/answer_property_service.dart';
import 'package:beta/application/services/answer_service.dart';
import 'package:beta/application/services/coupon_linked_to_term_service.dart';
import 'package:beta/application/services/coupon_service.dart';
import 'package:beta/application/services/database/shared.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/ebook_service.dart';
import 'package:beta/application/services/fcm_topic_service.dart';
import 'package:beta/application/services/flashcard_service.dart';
import 'package:beta/application/services/http_request_service.dart';
import 'package:beta/application/services/path/shared.dart';
import 'package:beta/application/services/question_linked_to_tag_service.dart';
import 'package:beta/application/services/question_media_service.dart';
import 'package:beta/application/services/question_property_service.dart';
import 'package:beta/application/services/question_service.dart';
import 'package:beta/application/services/question_tag_property_service.dart';
import 'package:beta/application/services/question_tag_service.dart';
import 'package:beta/application/services/related_term_service.dart';
import 'package:beta/application/services/term_label_service.dart';
import 'package:beta/application/services/term_last_access_service.dart';
import 'package:beta/application/services/term_linked_to_label_service.dart';
import 'package:beta/application/services/term_linked_to_tag_service.dart';
import 'package:beta/application/services/term_property_service.dart';
import 'package:beta/application/services/term_service.dart';
import 'package:beta/application/services/term_tag_service.dart';
import 'package:beta/application/services/terms_parent_service.dart';
import 'package:beta/application/services/terms_with_questions_filtering_enabled_service.dart';
import 'package:beta/application/services/theme_service.dart';
import 'package:beta/application/services/tutorial_service.dart';
import 'package:beta/application/services/user_service.dart';
import 'package:beta/application/services/voice_note_service.dart';
import 'package:beta/infrastructure/clipboard_repository.dart';
import 'package:beta/infrastructure/connection_repository.dart';
import 'package:beta/infrastructure/firebase_repository.dart';
import 'package:beta/infrastructure/key_value_repository.dart';
import 'package:beta/infrastructure/package_repository.dart';
import 'package:beta/infrastructure/url_launcher_repository.dart';
import 'package:beta/presentation/voice_note/voice_note_screen_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';

import 'infrastructure/device/shared.dart';
import 'package:beta/infrastructure/screenshot/shared.dart';

import 'infrastructure/notification/shared.dart';

class MainController {
  static bool testing = false;

  static Future initServices() async {
    // if (testing) InAppWebViewPlatform.instance = MockWebViewPlatform();
    if (testing == false) {
      WidgetsFlutterBinding.ensureInitialized();
      if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
        await InAppWebViewController.setWebContentsDebuggingEnabled(kDebugMode);
      }
    }
    KeyValue keyValue = await KeyValue().initialise();
    if (testing == false) await EasyLocalization.ensureInitialized();
    Get.put(await DeviceRepository().initialise());
    PackageRepository packageRepository =
        Get.put(await PackageRepository().initialise());
    FirebaseRepository firebaseRepository =
        Get.put(await FirebaseRepository().initialise());
    Get.put(keyValue);
    Get.put(UrlLauncherRepository());
    Get.put(ScreenshotRepository());
    Get.put(ConnectionRepository());
    DatabaseService databaseService = constructDb();
    Get.put(databaseService);
    Get.put(ThemeService(keyValue: keyValue));
    Get.put(QuestionPropertyService(databaseService: databaseService));
    Get.put(AnswerPropertyService(databaseService: databaseService));
    Get.put(TermLastAccessService(databaseService: databaseService));
    Get.put(CouponService(databaseService: databaseService));
    Get.put(TutorialService(keyValue: keyValue));
    Get.put(UserService(keyValue: keyValue));
    Get.put(TermService(
        databaseService: databaseService,
        firebaseRepository: firebaseRepository));
    Get.put(RelatedTermService(databaseService: databaseService));
    Get.put(TermsWithQuestionsFilteringEnabledService(
        databaseService: databaseService));
    Get.put(TermsParentService(databaseService: databaseService));
    Get.put(TermLinkedToTagService(databaseService: databaseService));
    Get.put(TermTagService(databaseService: databaseService));
    Get.put(TermLinkedToLabelService(databaseService: databaseService));
    Get.put(TermLabelService(databaseService: databaseService));
    Get.put(FCMTopicService(databaseService: databaseService));
    Get.put(CouponLinkedToTermService(databaseService: databaseService));
    Get.put(HttpRequestService(databaseService: databaseService));
    Get.put(EbookService(databaseService: databaseService));
    Get.put(VoiceNoteService(databaseService: databaseService));
    Get.put(QuestionService(databaseService: databaseService));
    Get.put(AnswerService(databaseService: databaseService));
    Get.put(FlashcardService(databaseService: databaseService));
    Get.put(QuestionMediaService(databaseService: databaseService));
    Get.put(QuestionTagService(databaseService: databaseService));
    Get.put(QuestionLinkedToTagService(databaseService: databaseService));
    Get.put(TermPropertyService(databaseService: databaseService));
    Get.put(QuestionTagPropertyService(databaseService: databaseService));
    AudioPlayer audioPlayer = Get.put(AudioPlayer());
    if (testing) {
      Get.put<AudioHandler>(MockAudioHandler());
    } else {
      Get.put(await AudioService.init<AudioHandler>(
        builder: () => AudioPlayerHandler(audioPlayer),
        config: AudioServiceConfig(
          androidNotificationChannelId:
              '${packageRepository.getPackageName()}.channel.audio',
          androidNotificationChannelName:
              packageRepository.getApplicationName(),
          androidNotificationOngoing: true,
        ),
      ));
    }
    Get.put(PathService());
    Get.put(NotificationRepository());
    Get.put(ClipboardRepository());
  }
}

class MockAudioHandler extends Mock implements AudioHandler {
  @override
  Future<void> addQueueItem(MediaItem mediaItem) async {}

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {}

  @override
  Future<void> androidAdjustRemoteVolume(
      AndroidVolumeDirection direction) async {}

  @override
  ValueStream<AndroidPlaybackInfo> get androidPlaybackInfo =>
      BehaviorSubject<AndroidPlaybackInfo>().stream;

  @override
  Future<void> androidSetRemoteVolume(int volumeIndex) async {}

  @override
  Future<void> click([MediaButton button = MediaButton.media]) async {}

  @override
  Future customAction(String name, [Map<String, dynamic>? extras]) async {}

  @override
  Stream get customEvent => const Stream.empty();

  @override
  ValueStream get customState => BehaviorSubject().stream;

  @override
  Future<void> fastForward() async {}

  @override
  Future<List<MediaItem>> getChildren(String parentMediaId,
      [Map<String, dynamic>? options]) async {
    return [];
  }

  @override
  Future<MediaItem?> getMediaItem(String mediaId) async {
    return null;
  }

  @override
  Future<void> insertQueueItem(int index, MediaItem mediaItem) async {}

  @override
  ValueStream<MediaItem?> get mediaItem => BehaviorSubject<MediaItem?>().stream;

  @override
  Future<void> onNotificationDeleted() async {}

  @override
  Future<void> onTaskRemoved() async {}

  @override
  Future<void> pause() async {}

  @override
  Future<void> play() async {}

  @override
  Future<void> playFromMediaId(String mediaId,
      [Map<String, dynamic>? extras]) async {}

  @override
  Future<void> playFromSearch(String query,
      [Map<String, dynamic>? extras]) async {}

  @override
  Future<void> playFromUri(Uri uri, [Map<String, dynamic>? extras]) async {}

  @override
  Future<void> playMediaItem(MediaItem mediaItem) async {}

  @override
  ValueStream<PlaybackState> get playbackState =>
      BehaviorSubject<PlaybackState>().shareValueSeeded(PlaybackState());

  @override
  Future<void> prepare() async {}

  @override
  Future<void> prepareFromMediaId(String mediaId,
      [Map<String, dynamic>? extras]) async {}

  @override
  Future<void> prepareFromSearch(String query,
      [Map<String, dynamic>? extras]) async {}

  @override
  Future<void> prepareFromUri(Uri uri, [Map<String, dynamic>? extras]) async {}

  @override
  ValueStream<List<MediaItem>> get queue =>
      BehaviorSubject<List<MediaItem>>().stream;

  @override
  ValueStream<String> get queueTitle => BehaviorSubject<String>().stream;

  @override
  ValueStream<RatingStyle> get ratingStyle =>
      BehaviorSubject<RatingStyle>().stream;

  @override
  Future<void> removeQueueItem(MediaItem mediaItem) async {}

  @override
  Future<void> removeQueueItemAt(int index) async {}

  @override
  Future<void> rewind() async {}

  @override
  Future<List<MediaItem>> search(String query,
      [Map<String, dynamic>? extras]) async {
    return [];
  }

  @override
  Future<void> seek(Duration position) async {}

  @override
  Future<void> seekBackward(bool begin) async {}

  @override
  Future<void> seekForward(bool begin) async {}

  @override
  Future<void> setCaptioningEnabled(bool enabled) async {}

  @override
  Future<void> setRating(Rating rating, [Map<String, dynamic>? extras]) async {}

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {}

  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode shuffleMode) async {}

  @override
  Future<void> setSpeed(double speed) async {}

  @override
  Future<void> skipToNext() async {}

  @override
  Future<void> skipToPrevious() async {}

  @override
  Future<void> skipToQueueItem(int index) async {}

  @override
  Future<void> stop() async {}

  @override
  ValueStream<Map<String, dynamic>> subscribeToChildren(String parentMediaId) {
    return BehaviorSubject<Map<String, dynamic>>().stream;
  }

  @override
  Future<void> updateMediaItem(MediaItem mediaItem) async {}

  @override
  Future<void> updateQueue(List<MediaItem> queue) async {}
}
