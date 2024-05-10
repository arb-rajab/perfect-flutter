import 'package:beta/constants/string_constant.dart';
import 'package:beta/constants/tutorial_constant.dart';
import 'package:beta/presentation/enter_coupon/enter_coupon_screen.dart';
import 'package:beta/presentation/home/browse_terms_tab.dart';
import 'package:beta/presentation/home/browse_terms_tab_controller.dart';
import 'package:beta/presentation/home/drawer_widget.dart';
import 'package:beta/presentation/home/home_screen_controller.dart';
import 'package:beta/presentation/home/recent_terms_tab.dart';
import 'package:beta/presentation/home/terms_listing_controller.dart';
import 'package:beta/presentation/notifications/notifications_screen.dart';
import 'package:beta/presentation/settings/settings_screen.dart';
import 'package:beta/presentation/widgets/rectangle_widget.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:upgrader/upgrader.dart';

class HomeScreen extends StatelessWidget with WidgetsBindingObserver {
  static String route = '/home';
  final GlobalKey addCouponKey = GlobalKey();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (Get.isRegistered<BrowseTermsTabController>()) {
          BrowseTermsTabController browseTermsTabController = Get.find();
          browseTermsTabController.refresh();
        }
        break;
      default:
    }
  }

  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Get.delete<HomeScreenController>();
    Get.put(HomeScreenController(context));
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
          onPressed: () async {
            await Navigator.pushNamed(context, EnterCouponScreen.route);
            Get.find<TermsListingController>().fetch!();
          },
          icon: const Icon(EnterCouponScreen.icon),
          label: Text(EnterCouponScreen.title)),
      tabs: [
        Tab(
          icon: const Icon(Icons.article),
          text: StringConstant.browseTerms.tr(),
        ),
        Tab(
          icon: const Icon(Icons.history),
          text: StringConstant.recentTerms.tr(),
        )
      ],
      child: UpgradeAlert(
        child: const TabBarView(
          children: [BrowseTermsTab(), RecentTermsTab()],
        ),
      ),
    );
  }
}
