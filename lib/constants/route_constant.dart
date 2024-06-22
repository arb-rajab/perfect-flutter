import 'package:beta/main.dart';
import 'package:beta/presentation/choose_term/choose_term_screen.dart';
import 'package:beta/presentation/contact_us/contact_us_screen.dart';
import 'package:beta/presentation/coupons/coupons_screen.dart';
import 'package:beta/presentation/enter_coupon/enter_coupon_screen.dart';
import 'package:beta/presentation/frequent_questions/frequent_questions_screen.dart';
import 'package:beta/presentation/home/home_screen.dart';
import 'package:beta/presentation/notifications/notifications_screen.dart';
import 'package:beta/presentation/printed_qr_scanner/printed_qr_scanner_screen.dart';
import 'package:beta/presentation/question_medias/question_medias_screen.dart';
import 'package:beta/presentation/questions/questions_screen.dart';
import 'package:beta/presentation/questions_report/questions_report_screen.dart';
import 'package:beta/presentation/scan_qr/scan_qr_screen.dart';
import 'package:beta/presentation/settings/settings_screen.dart';
import 'package:beta/presentation/splash/splash_screen.dart';
import 'package:beta/presentation/web/web_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(initialLocation: SplashScreen.route, observers: [
  routeObserver
], routes: [
  GoRoute(
      path: SplashScreen.route,
      builder: (context, state) => const SplashScreen()),
  GoRoute(
      path: HomeScreen.route, builder: (context, state) => const HomeScreen()),
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
      builder: (context, state) => const QuestionsReportScreen()),
  GoRoute(
    path: QuestionMediasScreen.route,
    builder: (context, state) => const QuestionMediasScreen(),
  )
]);
