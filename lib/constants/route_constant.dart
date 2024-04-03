import 'package:beta/presentation/coupons/coupons_screen.dart';
import 'package:beta/presentation/home/home_screen.dart';
import 'package:beta/presentation/notifications/notifications_screen.dart';
import 'package:beta/presentation/printed_qr_scanner/printed_qr_scanner_screen.dart';
import 'package:beta/presentation/settings/settings_screen.dart';
import 'package:beta/presentation/splash/splash_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.route: (context) => const SplashScreen(),
  HomeScreen.route: (context) => const HomeScreen(),
  NotificationsScreen.route: (context) => const NotificationsScreen(),
  SettingsScreen.route: (context) => const SettingsScreen(),
  CouponsScreen.route: (context) => const CouponsScreen(),
  PrintedQrScannerScreen.route: (context) => const PrintedQrScannerScreen()
};
