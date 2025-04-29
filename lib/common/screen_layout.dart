import 'package:flutter/widgets.dart';

class ScreenLayout {
  static bool isExtraSmall(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  static bool isSmall(BuildContext context) =>
      !isExtraSmall(context) && MediaQuery.of(context).size.width < 992;

  static bool isMedium(BuildContext context) =>
      !(isExtraSmall(context) || isSmall(context)) &&
      MediaQuery.of(context).size.width < 1200;

  static bool isLarge(BuildContext context) =>
      !(isExtraSmall(context) || isSmall(context) || isMedium(context));
}
