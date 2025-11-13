import 'package:app_links/app_links.dart';
import 'package:beta/application/services/theme_service.dart';
import 'package:beta/configs/colors.dart';
import 'package:beta/configs/locals.dart';
import 'package:beta/constants/route_constant.dart';
import 'package:beta/main_controller.dart';
import 'package:beta/presentation/splash/splash_screen.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flash/flash_helper.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

Future<void> main() async {
  await MainController.initServices();
  runApp(EasyLocalization(
      supportedLocales: supportedLocals,
      path: 'assets/translations',
      fallbackLocale: supportedLocals[0],
      child: const MyApp()));
}

// Register the RouteObserver as a navigation observer.
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  final String defaultRoute;
  final Widget? child;
  const MyApp({super.key, this.defaultRoute = SplashScreen.route, this.child});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void _handleIncomingLinks() {
    AppLinks().uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        router(widget.defaultRoute)
            .go(uri.path); // Navigate to the corresponding route
      }
    }, onError: (Object err) {
      if (kDebugMode) {
        print('Failed to get initial link: $err');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _handleIncomingLinks();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeService themeService = Get.find();
    Get.put(context.locale.languageCode, tag: 'language code');
    if (widget.child != null) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        localizationsDelegates:
            MainController.testing ? null : context.localizationDelegates,
        supportedLocales: MainController.testing
            ? const <Locale>[Locale('en', 'US')]
            : context.supportedLocales,
        locale: MainController.testing ? supportedLocals[0] : context.locale,
        title: 'Perfect',
        // Theme config for FlexColorScheme version 7.3.x. Make sure you use
        // same or higher package version, but still same major version. If you
        // use a lower package version, some properties may not be supported.
        // In that case remove them after copying this theme to your app.
        builder: (context, child) {
          // Wrap with toast.
          child = Toast(navigatorKey: navigatorKey, child: child!);
          return child;
        },
        theme: FlexThemeData.light(
          primary: primaryColor,
          fontFamily: 'jf_flat',
          scheme: FlexScheme.greenM3,
          surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
          blendLevel: 7,
          subThemesData: const FlexSubThemesData(
            blendOnLevel: 10,
            blendOnColors: false,
            useMaterial3Typography: true,
            useM2StyleDividerInM3: true,
            alignedDropdown: true,
            useInputDecoratorThemeInDialogs: true,
          ),
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          useMaterial3: true,
          swapLegacyOnMaterial3: true,
          // To use the Playground font, add GoogleFonts package and uncomment
          // fontFamily: GoogleFonts.notoSans().fontFamily,
        ),
        darkTheme: FlexThemeData.dark(
          scheme: FlexScheme.greenM3,
          fontFamily: 'jf_flat',
          surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
          blendLevel: 13,
          subThemesData: const FlexSubThemesData(
            blendOnLevel: 20,
            useMaterial3Typography: true,
            useM2StyleDividerInM3: true,
            alignedDropdown: true,
            useInputDecoratorThemeInDialogs: true,
          ),
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          useMaterial3: true,
          swapLegacyOnMaterial3: true,
          // To use the Playground font, add GoogleFonts package and uncomment
          // fontFamily: GoogleFonts.notoSans().fontFamily,
        ),
        themeMode: themeService.getThemeMode(),
        home: ScreenWrapper(child: widget.child!),
      );
    }
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router(widget.defaultRoute),
      localizationsDelegates:
          MainController.testing ? null : context.localizationDelegates,
      supportedLocales: MainController.testing
          ? const <Locale>[Locale('en', 'US')]
          : context.supportedLocales,
      locale: MainController.testing ? supportedLocals[0] : context.locale,
      title: 'Perfect',
      // Theme config for FlexColorScheme version 7.3.x. Make sure you use
      // same or higher package version, but still same major version. If you
      // use a lower package version, some properties may not be supported.
      // In that case remove them after copying this theme to your app.
      builder: (context, child) {
        // Wrap with toast.
        child = Toast(navigatorKey: navigatorKey, child: child!);
        return child;
      },
      theme: FlexThemeData.light(
        primary: primaryColor,
        fontFamily: 'jf_flat',
        scheme: FlexScheme.greenM3,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 7,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 10,
          blendOnColors: false,
          useMaterial3Typography: true,
          useM2StyleDividerInM3: true,
          alignedDropdown: true,
          useInputDecoratorThemeInDialogs: true,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        // To use the Playground font, add GoogleFonts package and uncomment
        // fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.greenM3,
        fontFamily: 'jf_flat',
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 13,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 20,
          useMaterial3Typography: true,
          useM2StyleDividerInM3: true,
          alignedDropdown: true,
          useInputDecoratorThemeInDialogs: true,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        // To use the Playground font, add GoogleFonts package and uncomment
        // fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      themeMode: themeService.getThemeMode(),
    );
  }
}
