import 'package:beta/abstract/screenshot_repository_base.dart';

class ScreenshotRepository extends ScreenshotRepositoryBase {
  ScreenshotRepository({super.enabled});

  @override
  Future preventScreenshot() => throw UnimplementedError();
  @override
  Future allowScreenshot() => throw UnimplementedError();
}
