import 'package:beta/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/main.dart';
import 'package:beta/presentation/choose_term/choose_term_screen.dart' deferred as choose_term_screen;
import 'package:beta/presentation/contact_us/contact_us_screen.dart' deferred as contact_us_screen;
import 'package:beta/presentation/coupons/coupons_screen.dart' deferred as coupons_screen;
import 'package:beta/presentation/discussion/discussion_screen.dart' deferred as discussion_screen;
import 'package:beta/presentation/ebook/ebook_screen.dart' deferred as ebook_screen;
import 'package:beta/presentation/enter_coupon/enter_coupon_screen.dart' deferred as enter_coupon_screen;
import 'package:beta/presentation/flashcards/flashcards_screen.dart' deferred as flashcards_screen;
import 'package:beta/presentation/frequent_questions/frequent_questions_screen.dart' deferred as frequent_questions_screen;
import 'package:beta/presentation/home/home_screen.dart' deferred as home_screen;
import 'package:beta/presentation/notifications/notifications_screen.dart' deferred as notifications_screen;
import 'package:beta/presentation/printed_qr_scanner/printed_qr_scanner_screen.dart' deferred as printed_qr_scanner_screen;
import 'package:beta/presentation/product/product_screen.dart' deferred as product_screen;
import 'package:beta/presentation/media_slider/media_slider_screen.dart' deferred as media_slider_screen;
import 'package:beta/presentation/questions/questions_screen.dart' deferred as questions_screen;
import 'package:beta/presentation/questions_report/questions_report_screen.dart' deferred as questions_report_screen;
import 'package:beta/presentation/scan_qr/scan_qr_screen.dart' deferred as scan_qr_screen;
import 'package:beta/presentation/settings/settings_screen.dart' deferred as settings_screen;
import 'package:beta/presentation/splash/splash_screen.dart' deferred as splash_screen;
import 'package:beta/presentation/voice_note/voice_note_screen.dart' deferred as voice_note_screen;
import 'package:beta/presentation/web/web_screen.dart' deferred as web_screen;
import 'package:beta/presentation/youtube_video/youtube_video_screen.dart' deferred as youtube_video_screen;
import 'package:go_router/go_router.dart';

Widget _deferredWidgetLoader(Future<void> Function() loadLibrary, Widget Function() screenBuilder) {
  return FutureBuilder(
    future: loadLibrary(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        return screenBuilder();
      } else {
        return const LoadingWidget();
      }
    },
  );
}

GoRouter router(String defaultRoute) => GoRouter(
  initialLocation: defaultRoute,
  observers: [routeObserver],
  navigatorKey: navigatorKey,
  routes: [
    GoRoute(
      path: splash_screen.SplashScreen.route,
      builder: (context, state) => _deferredWidgetLoader(
        splash_screen.loadLibrary,
        () => splash_screen.SplashScreen(),
      ),
    ),
    GoRoute(
      path: home_screen.HomeScreen.route,
      builder: (context, state) => _deferredWidgetLoader(
        home_screen.loadLibrary,
        () => home_screen.HomeScreen(),
      ),
    ),
    GoRoute(
      path: notifications_screen.NotificationsScreen.route,
      builder: (context, state) => _deferredWidgetLoader(
        notifications_screen.loadLibrary,
        () => notifications_screen.NotificationsScreen(),
      ),
    ),
    GoRoute(
      path: settings_screen.SettingsScreen.route,
      builder: (context, state) => _deferredWidgetLoader(
        settings_screen.loadLibrary,
        () => settings_screen.SettingsScreen(),
      ),
    ),
    GoRoute(
      path: coupons_screen.CouponsScreen.route,
      builder: (context, state) => _deferredWidgetLoader(
        coupons_screen.loadLibrary,
        () => coupons_screen.CouponsScreen(),
      ),
    ),
    GoRoute(
      path: printed_qr_scanner_screen.PrintedQrScannerScreen.route,
      builder: (context, state) => _deferredWidgetLoader(
        printed_qr_scanner_screen.loadLibrary,
        () => printed_qr_scanner_screen.PrintedQrScannerScreen(),
      ),
    ),
    GoRoute(
      path: enter_coupon_screen.EnterCouponScreen.route,
      builder: (context, state) => _deferredWidgetLoader(
        enter_coupon_screen.loadLibrary,
        () => enter_coupon_screen.EnterCouponScreen(),
      ),
    ),
    GoRoute(
      path: choose_term_screen.ChooseTermScreen.route,
      builder: (context, state) => _deferredWidgetLoader(
        choose_term_screen.loadLibrary,
        () => choose_term_screen.ChooseTermScreen(),
      ),
    ),
    GoRoute(
      path: contact_us_screen.ContactUsScreen.route,
      builder: (context, state) => _deferredWidgetLoader(
        contact_us_screen.loadLibrary,
        () => contact_us_screen.ContactUsScreen(),
      ),
    ),
    GoRoute(
      path: frequent_questions_screen.FrequentQuestionsScreen.route,
      builder: (context, state) => _deferredWidgetLoader(
        frequent_questions_screen.loadLibrary,
        () => frequent_questions_screen.FrequentQuestionsScreen(),
      ),
    ),
    GoRoute(
      path: scan_qr_screen.ScanQrScreen.route,
      builder: (context, state) => _deferredWidgetLoader(
        scan_qr_screen.loadLibrary,
        () => scan_qr_screen.ScanQrScreen(),
      ),
    ),
    GoRoute(
      path: questions_screen.QuestionsScreen.route,
      builder: (context, state) => _deferredWidgetLoader(
        questions_screen.loadLibrary,
        () => questions_screen.QuestionsScreen(),
      ),
    ),
    GoRoute(
      path: questions_screen.QuestionsScreen.uuidRoute,
      builder: (context, state) => _deferredWidgetLoader(
        questions_screen.loadLibrary,
        () => questions_screen.QuestionsScreen(uuid: state.pathParameters['uuid']),
      ),
    ),
    GoRoute(
      path: web_screen.WebScreen.route,
      builder: (context, state) => _deferredWidgetLoader(
        web_screen.loadLibrary,
        () => web_screen.WebScreen(),
      ),
    ),
    GoRoute(
      path: questions_report_screen.QuestionsReportScreen.route,
      builder: (context, state) => _deferredWidgetLoader(
        questions_report_screen.loadLibrary,
        () => questions_report_screen.QuestionsReportScreen(),
      ),
    ),
    GoRoute(
      path: media_slider_screen.MediaSliderScreen.route,
      builder: (context, state) => _deferredWidgetLoader(
        media_slider_screen.loadLibrary,
        () => media_slider_screen.MediaSliderScreen(),
      ),
    ),
    GoRoute(
      path: ebook_screen.EbookScreen.route,
      builder: (context, state) => _deferredWidgetLoader(
        ebook_screen.loadLibrary,
        () => ebook_screen.EbookScreen(),
      ),
    ),
    GoRoute(
      path: youtube_video_screen.YoutubeVideoScreen.route,
      builder: (context, state) => _deferredWidgetLoader(
        youtube_video_screen.loadLibrary,
        () => youtube_video_screen.YoutubeVideoScreen(),
      ),
    ),
    GoRoute(
      path: discussion_screen.DiscussionScreen.route,
      builder: (context, state) => _deferredWidgetLoader(
        discussion_screen.loadLibrary,
        () => discussion_screen.DiscussionScreen(
          type: state.pathParameters['itemType']!,
          id: state.pathParameters['itemId']!,
        ),
      ),
    ),
    GoRoute(
      path: flashcards_screen.FlashcardsScreen.route,
      builder: (context, state) => _deferredWidgetLoader(
        flashcards_screen.loadLibrary,
        () => flashcards_screen.FlashcardsScreen(),
      ),
    ),
    GoRoute(
      path: voice_note_screen.VoiceNoteScreen.route,
      builder: (context, state) => _deferredWidgetLoader(
        voice_note_screen.loadLibrary,
        () => voice_note_screen.VoiceNoteScreen(),
      ),
    ),
    GoRoute(
      path: product_screen.ProductScreen.route,
      builder: (context, state) => _deferredWidgetLoader(
        product_screen.loadLibrary,
        () => product_screen.ProductScreen(
          id: Id(int.tryParse(state.pathParameters['productId']!)),
        ),
      ),
    ),
  ],
);
