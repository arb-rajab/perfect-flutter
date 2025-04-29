import 'package:beta/main_controller.dart';
import 'package:flutter/services.dart';

class ClipboardRepository {
  String testData = '';

  Future setText(String text) {
    if (MainController.testing) {
      testData = text;
      return Future.value();
    }
    return Clipboard.setData(ClipboardData(text: text));
  }

  Future<String> getText() async {
    if (MainController.testing) {
      return Future.value(testData);
    }
    return (await Clipboard.getData('text/plain'))!.text!;
  }
}
