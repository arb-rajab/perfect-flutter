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
import 'package:flutter_tex/flutter_tex.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/src/streams/value_stream.dart';

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
      TeXRederingServer.renderingEngine = const TeXViewRenderingEngine.katex();
      if (!kIsWeb) {
        await TeXRederingServer.run();
        await TeXRederingServer.initController();
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

class MockAudioHandler implements AudioHandler {
  @override
  Future<void> addQueueItem(MediaItem mediaItem) {
    throw UnimplementedError();
  }

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) {
    throw UnimplementedError();
  }

  @override
  Future<void> androidAdjustRemoteVolume(AndroidVolumeDirection direction) {
    throw UnimplementedError();
  }

  @override
  ValueStream<AndroidPlaybackInfo> get androidPlaybackInfo =>
      throw UnimplementedError();

  @override
  Future<void> androidSetRemoteVolume(int volumeIndex) {
    // TODO: implement androidSetRemoteVolume
    throw UnimplementedError();
  }

  @override
  Future<void> click([MediaButton button = MediaButton.media]) {
    // TODO: implement click
    throw UnimplementedError();
  }

  @override
  Future customAction(String name, [Map<String, dynamic>? extras]) {
    // TODO: implement customAction
    throw UnimplementedError();
  }

  @override
  // TODO: implement customEvent
  Stream get customEvent => throw UnimplementedError();

  @override
  // TODO: implement customState
  ValueStream get customState => throw UnimplementedError();

  @override
  Future<void> fastForward() {
    // TODO: implement fastForward
    throw UnimplementedError();
  }

  @override
  Future<List<MediaItem>> getChildren(String parentMediaId,
      [Map<String, dynamic>? options]) {
    // TODO: implement getChildren
    throw UnimplementedError();
  }

  @override
  Future<MediaItem?> getMediaItem(String mediaId) {
    // TODO: implement getMediaItem
    throw UnimplementedError();
  }

  @override
  Future<void> insertQueueItem(int index, MediaItem mediaItem) {
    // TODO: implement insertQueueItem
    throw UnimplementedError();
  }

  @override
  // TODO: implement mediaItem
  ValueStream<MediaItem?> get mediaItem => throw UnimplementedError();

  @override
  Future<void> onNotificationDeleted() {
    // TODO: implement onNotificationDeleted
    throw UnimplementedError();
  }

  @override
  Future<void> onTaskRemoved() {
    // TODO: implement onTaskRemoved
    throw UnimplementedError();
  }

  @override
  Future<void> pause() {
    // TODO: implement pause
    throw UnimplementedError();
  }

  @override
  Future<void> play() {
    // TODO: implement play
    throw UnimplementedError();
  }

  @override
  Future<void> playFromMediaId(String mediaId, [Map<String, dynamic>? extras]) {
    // TODO: implement playFromMediaId
    throw UnimplementedError();
  }

  @override
  Future<void> playFromSearch(String query, [Map<String, dynamic>? extras]) {
    // TODO: implement playFromSearch
    throw UnimplementedError();
  }

  @override
  Future<void> playFromUri(Uri uri, [Map<String, dynamic>? extras]) {
    // TODO: implement playFromUri
    throw UnimplementedError();
  }

  @override
  Future<void> playMediaItem(MediaItem mediaItem) {
    // TODO: implement playMediaItem
    throw UnimplementedError();
  }

  @override
  // TODO: implement playbackState
  ValueStream<PlaybackState> get playbackState => throw UnimplementedError();

  @override
  Future<void> prepare() {
    // TODO: implement prepare
    throw UnimplementedError();
  }

  @override
  Future<void> prepareFromMediaId(String mediaId,
      [Map<String, dynamic>? extras]) {
    // TODO: implement prepareFromMediaId
    throw UnimplementedError();
  }

  @override
  Future<void> prepareFromSearch(String query, [Map<String, dynamic>? extras]) {
    // TODO: implement prepareFromSearch
    throw UnimplementedError();
  }

  @override
  Future<void> prepareFromUri(Uri uri, [Map<String, dynamic>? extras]) {
    // TODO: implement prepareFromUri
    throw UnimplementedError();
  }

  @override
  // TODO: implement queue
  ValueStream<List<MediaItem>> get queue => throw UnimplementedError();

  @override
  // TODO: implement queueTitle
  ValueStream<String> get queueTitle => throw UnimplementedError();

  @override
  // TODO: implement ratingStyle
  ValueStream<RatingStyle> get ratingStyle => throw UnimplementedError();

  @override
  Future<void> removeQueueItem(MediaItem mediaItem) {
    // TODO: implement removeQueueItem
    throw UnimplementedError();
  }

  @override
  Future<void> removeQueueItemAt(int index) {
    // TODO: implement removeQueueItemAt
    throw UnimplementedError();
  }

  @override
  Future<void> rewind() {
    // TODO: implement rewind
    throw UnimplementedError();
  }

  @override
  Future<List<MediaItem>> search(String query, [Map<String, dynamic>? extras]) {
    // TODO: implement search
    throw UnimplementedError();
  }

  @override
  Future<void> seek(Duration position) {
    // TODO: implement seek
    throw UnimplementedError();
  }

  @override
  Future<void> seekBackward(bool begin) {
    // TODO: implement seekBackward
    throw UnimplementedError();
  }

  @override
  Future<void> seekForward(bool begin) {
    // TODO: implement seekForward
    throw UnimplementedError();
  }

  @override
  Future<void> setCaptioningEnabled(bool enabled) {
    // TODO: implement setCaptioningEnabled
    throw UnimplementedError();
  }

  @override
  Future<void> setRating(Rating rating, [Map<String, dynamic>? extras]) {
    // TODO: implement setRating
    throw UnimplementedError();
  }

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) {
    // TODO: implement setRepeatMode
    throw UnimplementedError();
  }

  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode shuffleMode) {
    // TODO: implement setShuffleMode
    throw UnimplementedError();
  }

  @override
  Future<void> setSpeed(double speed) {
    // TODO: implement setSpeed
    throw UnimplementedError();
  }

  @override
  Future<void> skipToNext() {
    // TODO: implement skipToNext
    throw UnimplementedError();
  }

  @override
  Future<void> skipToPrevious() {
    // TODO: implement skipToPrevious
    throw UnimplementedError();
  }

  @override
  Future<void> skipToQueueItem(int index) {
    // TODO: implement skipToQueueItem
    throw UnimplementedError();
  }

  @override
  Future<void> stop() {
    // TODO: implement stop
    throw UnimplementedError();
  }

  @override
  ValueStream<Map<String, dynamic>> subscribeToChildren(String parentMediaId) {
    // TODO: implement subscribeToChildren
    throw UnimplementedError();
  }

  @override
  Future<void> updateMediaItem(MediaItem mediaItem) {
    // TODO: implement updateMediaItem
    throw UnimplementedError();
  }

  @override
  Future<void> updateQueue(List<MediaItem> queue) {
    // TODO: implement updateQueue
    throw UnimplementedError();
  }
}
