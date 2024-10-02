import 'package:beta/application/services/question_tag_service.dart';
import 'package:beta/domain/question_tag_data.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/choose_term/choose_term_screen.dart';
import 'package:beta/presentation/contact_us/contact_us_screen.dart';
import 'package:beta/presentation/coupons/coupons_screen.dart';
import 'package:beta/presentation/ebook/ebook_screen.dart';
import 'package:beta/presentation/enter_coupon/enter_coupon_screen.dart';
import 'package:beta/presentation/frequent_questions/frequent_questions_screen.dart';
import 'package:beta/presentation/home/browse_terms_tab_controller.dart';
import 'package:beta/presentation/home/home_screen.dart';
import 'package:beta/presentation/home/question_tag_listing_controller.dart';
import 'package:beta/presentation/home/terms_controller.dart';
import 'package:beta/presentation/home/terms_listing_controller.dart';
import 'package:beta/presentation/notifications/notifications_screen.dart';
import 'package:beta/presentation/printed_qr_scanner/printed_qr_scanner_screen.dart';
import 'package:beta/presentation/question_medias/question_medias_screen.dart';
import 'package:beta/presentation/questions/questions_controller.dart';
import 'package:beta/presentation/questions/questions_screen.dart';
import 'package:beta/presentation/questions_report/questions_report_screen.dart';
import 'package:beta/presentation/scan_qr/scan_qr_screen.dart';
import 'package:beta/presentation/settings/settings_screen.dart';
import 'package:beta/presentation/splash/splash_screen.dart';
import 'package:beta/presentation/web/web_screen.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(initialLocation: SplashScreen.route, observers: [
  routeObserver
], routes: [
  GoRoute(
      path: SplashScreen.route,
      builder: (context, state) => const SplashScreen()),
  GoRoute(
      path: HomeScreen.route,
      onExit: (context, state) async {
        BrowseTermsTabController controller = Get.find();
        QuestionTagListingController questionTagListingController = Get.find();
        TermsListingController termsListingController = Get.find();
        TermsController termsController = Get.find();
        if (controller.questionTagDatas.isNotEmpty) {
          QuestionTagService questionTagService = Get.find();
          controller.backPressed = true;
          List<QuestionTagData> questionTagDatas = [];
          questionTagListingController.numberOfOthers = 0;

          if (questionTagListingController.questionTagListing.isNotEmpty) {
            questionTagListingController.questionTagListing.removeLast();
            await Get.delete<QuestionTagData>();
            TermData termData = Get.find();
            if (questionTagListingController.questionTagListing.isEmpty) {
              questionTagDatas =
                  await questionTagService.getTermQuestionsTags(termData);
            } else {
              QuestionTagListingItem questionTagListingItem =
                  questionTagListingController.questionTagListing.last;
              QuestionTagData questionTagData =
                  questionTagListingItem.questionTagData;
              Get.put(questionTagData);

              questionTagDatas = await questionTagService
                  .getAllQuestionsTagChild(questionTagData);
              questionTagListingController.numberOfOthers =
                  await questionTagService.getNumberOfOtherQuestionsQuestionTag(
                      questionTagData, termData);
            }
          }
          questionTagListingController.items.clear();
          controller.questionTagDatas = questionTagDatas;
          questionTagListingController.init();
          return false;
        }
        if (controller.termsTags.isNotEmpty) {
          controller.backPressed = true;
          termsListingController.termsListing.removeLast();
          if (termsListingController.termsListing.isNotEmpty) {
            TermData termData = termsListingController.termsListing.last;
            await Get.delete<TermData>();
            Get.put(termData);
          }
          controller.termsTags.clear();
          termsListingController.init();
          return false;
        }
        controller.backPressed = true;
        if (termsListingController.termsListing.isEmpty) return true;
        await termsController.onPopScoped();
        return false;
        // return termsListingController.termsListing.isEmpty;
      },
      builder: (context, state) => const HomeScreen()),
  GoRoute(
      path: NotificationsScreen.route,
      builder: (context, state) => const NotificationsScreen()),
  GoRoute(
      path: SettingsScreen.route,
      builder: (context, state) => const SettingsScreen()),
  GoRoute(
      path: CouponsScreen.route,
      builder: (context, state) => const CouponsScreen()),
  GoRoute(
      path: PrintedQrScannerScreen.route,
      builder: (context, state) => const PrintedQrScannerScreen()),
  GoRoute(
      path: EnterCouponScreen.route,
      builder: (context, state) => const EnterCouponScreen()),
  GoRoute(
      path: ChooseTermScreen.route,
      builder: (context, state) => const ChooseTermScreen()),
  GoRoute(
      path: ContactUsScreen.route,
      builder: (context, state) => const ContactUsScreen()),
  GoRoute(
      path: FrequentQuestionsScreen.route,
      builder: (context, state) => const FrequentQuestionsScreen()),
  GoRoute(
      path: ScanQrScreen.route,
      builder: (context, state) => const ScanQrScreen()),
  GoRoute(
      path: QuestionsScreen.route,
      onExit: (context, state) {
        QuestionsController questionsController = Get.find();
        return questionsController.onPopInvoked();
      },
      builder: (context, state) => const QuestionsScreen()),
  GoRoute(
      path: QuestionsScreen.uuidRoute,
      onExit: (context, state) {
        QuestionsController questionsController = Get.find();
        return questionsController.onPopInvoked();
      },
      builder: (context, state) => QuestionsScreen(
            uuid: state.pathParameters['uuid'],
          )),
  GoRoute(
      path: WebScreen.route, builder: (context, state) => const WebScreen()),
  GoRoute(
      path: QuestionsReportScreen.route,
      builder: (context, state) => QuestionsReportScreen()),
  GoRoute(
    path: QuestionMediasScreen.route,
    builder: (context, state) => const QuestionMediasScreen(),
  ),
  GoRoute(
      path: EbookScreen.route,
      builder: (context, state) => const EbookScreen())
]);
