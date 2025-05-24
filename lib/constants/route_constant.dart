import 'package:beta/domain/value/id.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/choose_term/choose_term_screen.dart';
import 'package:beta/presentation/contact_us/contact_us_screen.dart';
import 'package:beta/presentation/coupons/coupons_screen.dart';
import 'package:beta/presentation/discussion/discussion_screen.dart';
import 'package:beta/presentation/ebook/ebook_screen.dart';
import 'package:beta/presentation/enter_coupon/enter_coupon_screen.dart';
import 'package:beta/presentation/flashcards/flashcards_screen.dart';
import 'package:beta/presentation/frequent_questions/frequent_questions_screen.dart';
import 'package:beta/presentation/home/home_screen.dart';
import 'package:beta/presentation/notifications/notifications_screen.dart';
import 'package:beta/presentation/printed_qr_scanner/printed_qr_scanner_screen.dart';
import 'package:beta/presentation/product/product_screen.dart';
import 'package:beta/presentation/media_slider/media_slider_screen.dart';
import 'package:beta/presentation/questions/questions_screen.dart';
import 'package:beta/presentation/questions_report/questions_report_screen.dart';
import 'package:beta/presentation/scan_qr/scan_qr_screen.dart';
import 'package:beta/presentation/settings/settings_screen.dart';
import 'package:beta/presentation/splash/splash_screen.dart';
import 'package:beta/presentation/voice_note/voice_note_screen.dart';
import 'package:beta/presentation/web/web_screen.dart';
import 'package:beta/presentation/youtube_video/youtube_video_screen.dart';
import 'package:go_router/go_router.dart';

GoRouter router(defaultRoute) =>
    GoRouter(initialLocation: defaultRoute, observers: [
  routeObserver
],
    navigatorKey: navigatorKey,
    routes: [
  GoRoute(
      path: SplashScreen.route,
      builder: (context, state) => const SplashScreen()),
  GoRoute(
      path: HomeScreen.route,
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
      builder: (context, state) => const QuestionsScreen()),
  GoRoute(
      path: QuestionsScreen.uuidRoute,
      builder: (context, state) => QuestionsScreen(
            uuid: state.pathParameters['uuid'],
          )),
  GoRoute(
      path: WebScreen.route, builder: (context, state) => const WebScreen()),
  GoRoute(
      path: QuestionsReportScreen.route,
      builder: (context, state) => QuestionsReportScreen()),
  GoRoute(
        path: MediaSliderScreen.route,
        builder: (context, state) => const MediaSliderScreen(),
  ),
  GoRoute(
      path: EbookScreen.route,
      builder: (context, state) => const EbookScreen()),
  GoRoute(
      path: YoutubeVideoScreen.route,
      builder: (context, state) => const YoutubeVideoScreen()),
  GoRoute(
      path: DiscussionScreen.route,
      builder: (context, state) => DiscussionScreen(
            type: state.pathParameters['itemType']!,
            id: state.pathParameters['itemId']!,
          )),
  GoRoute(
      path: FlashcardsScreen.route,
      builder: (context, state) => const FlashcardsScreen()),
  GoRoute(
      path: VoiceNoteScreen.route,
      builder: (context, state) => const VoiceNoteScreen()),
  GoRoute(
      path: ProductScreen.route,
      builder: (context, state) => ProductScreen(
          id: Id(int.tryParse(state.pathParameters['productId']!))))
]);
