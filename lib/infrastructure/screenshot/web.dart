import 'package:beta/abstract/screenshot_repository_base.dart';

class ScreenshotRepository extends ScreenshotRepositoryBase {
  ScreenshotRepository({super.enabled});

  @override
  Future preventScreenshot() => Future.value();
  @override
  Future allowScreenshot() => Future.value();
}
