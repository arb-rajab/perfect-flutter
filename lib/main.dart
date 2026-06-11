import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:beta/application/services/theme_service.dart';
import 'package:beta/configs/app.dart';
import 'package:beta/configs/colors.dart';
import 'package:beta/configs/locals.dart';
import 'package:beta/constants/route_constant.dart';
import 'package:beta/main_controller.dart';
import 'package:beta/presentation/splash/splash_screen.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:catcher_2/catcher_2.dart';
import 'package:clarity_flutter/clarity_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flash/flash_helper.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';

Future<void> main() async {
  await MainController.initServices();
  final config = ClarityConfig(projectId: clarityProjectId);

  Catcher2Options debugOptions = Catcher2Options(DialogReportMode(), [
    ConsoleHandler(),
  ]);

  /// Release configuration. Same as above, but once user accepts dialog, user will be prompted to send email with crash to support.
  Catcher2Options releaseOptions = Catcher2Options(DialogReportMode(), [
    EmailManualHandler(["support@email.com"]),
  ]);

  /// STEP 2. Pass your root widget (MyApp) along with Catcher 2 configuration:
  // Catcher2(
  //   rootWidget: ClarityWidget(
  //     clarityConfig: config,
  //     app: EasyLocalization(
  //       supportedLocales: supportedLocals,
  //       path: 'assets/translations',
  //       fallbackLocale: supportedLocals[0],
  //       child: const MyApp(),
  //     ),
  //   ),
  //   debugConfig: debugOptions,
  //   releaseConfig: releaseOptions,
  //   navigatorKey: navigatorKey,
  // );

  runApp(
    ClarityWidget(
      clarityConfig: config,
      app: EasyLocalization(
        supportedLocales: supportedLocals,
        path: 'assets/translations',
        fallbackLocale: supportedLocals[0],
        child: const MyApp(),
      ),
    ),
  );
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
  late final AppLinks appLinks;
  StreamSubscription<Uri>? _sub;
  late GoRouter routerConfig;

  Future<void> _initDeepLink() async {
    // 1) Initial link (cold start)
    final initialUri = await appLinks.getInitialLink();
    if (initialUri != null) {
      _handleUri(initialUri);
    }
  }

  void _handleUri(Uri initialUri) {
    final nav = navigatorKey.currentState;
    debugPrint('NAV READY: ${nav != null}');
    routerConfig.go(initialUri.path);
  }

  @override
  void initState() {
    super.initState();
    routerConfig = router(widget.defaultRoute);
    // 1. Handle cold start
    appLinks = AppLinks();
    _initDeepLink();

    // 2. Handle links while app is running / in background
    _sub = appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _handleUri(uri); // navigate to your screen
      }
    });
  }

  @override
  void dispose() {
    _sub?.cancel(); // clean up
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeService themeService = Get.find();
    if (!MainController.testing) {
      Get.put(context.locale.languageCode, tag: 'language code');
    }
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
      routerConfig: routerConfig,
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
