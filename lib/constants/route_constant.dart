import 'package:beta/presentation/choose_term/choose_term_screen.dart';
import 'package:beta/presentation/contact_us/contact_us_screen.dart';
import 'package:beta/presentation/coupons/coupons_screen.dart';
import 'package:beta/presentation/enter_coupon/enter_coupon_screen.dart';
import 'package:beta/presentation/frequent_questions/frequent_questions_screen.dart';
import 'package:beta/presentation/home/home_screen.dart';
import 'package:beta/presentation/notifications/notifications_screen.dart';
import 'package:beta/presentation/printed_qr_scanner/printed_qr_scanner_screen.dart';
import 'package:beta/presentation/scan_qr/scan_qr_screen.dart';
import 'package:beta/presentation/settings/settings_screen.dart';
import 'package:beta/presentation/splash/splash_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.route: (context) => const SplashScreen(),
  HomeScreen.route: (context) => HomeScreen(),
  NotificationsScreen.route: (context) => const NotificationsScreen(),
  SettingsScreen.route: (context) => const SettingsScreen(),
  CouponsScreen.route: (context) => const CouponsScreen(),
  PrintedQrScannerScreen.route: (context) => const PrintedQrScannerScreen(),
  EnterCouponScreen.route: (context) => const EnterCouponScreen(),
  ChooseTermScreen.route: (context) => const ChooseTermScreen(),
  ContactUsScreen.route: (context) => const ContactUsScreen(),
  FrequentQuestionsScreen.route: (context) => const FrequentQuestionsScreen(),
  ScanQrScreen.route: (context) => const ScanQrScreen()
};
