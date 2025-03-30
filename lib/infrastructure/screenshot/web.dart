import 'package:beta/abstract/screenshot_repository_base.dart';

class ScreenshotRepository implements ScreenshotRepositoryBase {
  @override
  Future preventScreenshot() => Future.value();
  @override
  Future allowScreenshot() => Future.value();
}
