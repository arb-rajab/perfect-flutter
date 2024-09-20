import 'package:beta/application/services/answer_property_service.dart';
import 'package:beta/application/services/answer_service.dart';
import 'package:beta/application/services/coupon_linked_to_term_service.dart';
import 'package:beta/application/services/coupon_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/ebook_service.dart';
import 'package:beta/application/services/fcm_topic_service.dart';
import 'package:beta/application/services/flashcard_service.dart';
import 'package:beta/application/services/http_request_service.dart';
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
import 'package:beta/infrastructure/connection_repository.dart';
import 'package:beta/infrastructure/device_repository.dart';
import 'package:beta/infrastructure/firebase_repository.dart';
import 'package:beta/infrastructure/key_value_repository.dart';
import 'package:beta/infrastructure/package_repository.dart';
import 'package:beta/infrastructure/screenshot_repository.dart';
import 'package:beta/infrastructure/url_launcher_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MainController {
  static bool testing = false;

  static Future initServices() async {
    if (testing == false) WidgetsFlutterBinding.ensureInitialized();
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      await InAppWebViewController.setWebContentsDebuggingEnabled(kDebugMode);
    }
    KeyValue keyValue = await KeyValue().initialise();
    if (testing == false) await EasyLocalization.ensureInitialized();
    DeviceRepository deviceRepository =
        Get.put(await DeviceRepository().initialise());
    PackageRepository packageRepository =
        Get.put(await PackageRepository().initialise());
    FirebaseRepository firebaseRepository =
        Get.put(await FirebaseRepository().initialise());
    Get.put(keyValue);
    Get.put(UrlLauncherRepository());
    Get.put(ScreenshotRepository());
    Get.put(ConnectionRepository());
    DatabaseService databaseService = DatabaseService(
        packageRepository: packageRepository,
        deviceRepository: deviceRepository);
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
  }
}
