import 'package:screen_protector/screen_protector.dart';

class ScreenshotRepository {
  Future preventScreenshot() => ScreenProtector.preventScreenshotOn();
  Future allowScreenshot() => ScreenProtector.preventScreenshotOff();
}
