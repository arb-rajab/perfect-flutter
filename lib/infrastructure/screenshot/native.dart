import 'package:beta/abstract/screenshot_repository_base.dart';
import 'package:screen_protector/screen_protector.dart';

class ScreenshotRepository implements ScreenshotRepositoryBase {
  @override
  Future preventScreenshot() => ScreenProtector.preventScreenshotOn();
  @override
  Future allowScreenshot() => ScreenProtector.preventScreenshotOff();
}
