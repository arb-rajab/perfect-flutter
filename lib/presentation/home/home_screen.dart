import 'package:beta/constants/string_constant.dart';
import 'package:beta/constants/tutorial_constant.dart';
import 'package:beta/presentation/enter_coupon/enter_coupon_screen.dart';
import 'package:beta/presentation/home/drawer_widget.dart';
import 'package:beta/presentation/notifications/notifications_screen.dart';
import 'package:beta/presentation/settings/settings_screen.dart';
import 'package:beta/presentation/widgets/rectangle_widget.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class HomeScreen extends StatelessWidget {
  static String route = '/home';
  final GlobalKey addCouponKey = GlobalKey();

  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      targets: [
        CustomTargetFocus(
            identify: TutorialConstant.addCoupon,
            keyTarget: addCouponKey,
            contents: [
              TargetContent(
                  builder: (context, controller) {
                    return RectangleWidget(
                        child: Text(StringConstant.addCouponDescription.tr()));
                  },
                  align: ContentAlign.top)
            ])
      ],
      actions: [
        IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, NotificationsScreen.route),
            icon: const Icon(NotificationsScreen.icon)),
        IconButton(
          icon: const Icon(SettingsScreen.icon),
          onPressed: () => Navigator.pushNamed(context, SettingsScreen.route),
        )
      ],
      drawer: const DrawerWidget(),
      floatingActionButton: FloatingActionButton.extended(
          key: addCouponKey,
          tooltip: EnterCouponScreen.title,
          heroTag: EnterCouponScreen.title,
          onPressed: () =>
              Navigator.pushNamed(context, EnterCouponScreen.route),
          icon: const Icon(EnterCouponScreen.icon),
          label: Text(EnterCouponScreen.title)),
      child: const Center(),
    );
  }
}
