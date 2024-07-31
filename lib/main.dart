import 'package:beta/application/services/theme_service.dart';
import 'package:beta/configs/locals.dart';
import 'package:beta/constants/route_constant.dart';
import 'package:beta/main_controller.dart';
import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

Future<void> main() async {
  await MainController.initServices();
  runApp(const AppWrapper());
}

//TODO delete if not used
class AppWrapper extends StatelessWidget {
  final Widget? home;
  const AppWrapper({super.key, this.home});

  @override
  Widget build(BuildContext context) {
    return DevicePreview(
        enabled: false,
        builder: (context) => EasyLocalization(
              supportedLocales: supportedLocals,
              path: 'assets/translations',
              fallbackLocale: supportedLocals[0],
              child: MyApp(home: home),
            ));
  }
}

// Register the RouteObserver as a navigation observer.
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatelessWidget {
  final Widget? home;
  const MyApp({super.key, this.home});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeService themeService = Get.find();
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler.linear(themeService.getScaleFactor())),
      child: MaterialApp.router(
        routerConfig: router,
        builder: DevicePreview.appBuilder,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'Flutter Demo',
        // Theme config for FlexColorScheme version 7.3.x. Make sure you use
        // same or higher package version, but still same major version. If you
        // use a lower package version, some properties may not be supported.
        // In that case remove them after copying this theme to your app.
        theme: FlexThemeData.light(
          scheme: FlexScheme.greenM3,
          surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
          blendLevel: 7,
          subThemesData: const FlexSubThemesData(
            blendOnLevel: 10,
            blendOnColors: false,
            useTextTheme: true,
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
          surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
          blendLevel: 13,
          subThemesData: const FlexSubThemesData(
            blendOnLevel: 20,
            useTextTheme: true,
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
      ),
    );
  }
}
