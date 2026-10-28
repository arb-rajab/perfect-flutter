import 'package:beta/abstract/screenshot_repository_base.dart';

class ScreenshotRepository extends ScreenshotRepositoryBase {
  @override
  Future preventScreenshot() => throw UnimplementedError();
  @override
  Future allowScreenshot() => throw UnimplementedError();
}
