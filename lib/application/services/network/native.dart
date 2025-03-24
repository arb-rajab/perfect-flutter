import 'dart:io';

import 'package:beta/helper/http_overrides.dart';

void setHttpOverrides() {
  HttpOverrides.global =
      MyHttpOverrides(); //In order to make post requests work with android api 23
}
