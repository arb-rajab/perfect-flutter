import 'package:beta/configs/app.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/constants/tutorial_constant.dart';
import 'package:beta/presentation/enter_coupon/enter_coupon_screen.dart';
import 'package:beta/presentation/home/browse_terms_tab.dart';
import 'package:beta/presentation/home/drawer_widget.dart';
import 'package:beta/presentation/home/home_screen_controller.dart';
import 'package:beta/presentation/home/new_terms_tab.dart';
import 'package:beta/presentation/home/recent_terms_tab.dart';
import 'package:beta/presentation/home/store_tab.dart';
import 'package:beta/presentation/home/terms_listing_controller.dart';
import 'package:beta/presentation/home/unstudied_terms_tab.dart';
import 'package:beta/presentation/home/updateable_terms_tab.dart';
import 'package:beta/presentation/notifications/notifications_screen.dart';
import 'package:beta/presentation/settings/settings_screen.dart';
import 'package:beta/presentation/widgets/rectangle_widget.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class HomeScreen extends StatefulWidget {
  static String route = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey addCouponKey = GlobalKey();
  late HomeScreenController homeScreenController;

  @override
  void initState() {
    Get.delete<HomeScreenController>();
    homeScreenController = Get.put(HomeScreenController(this));
    super.initState();
  }

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
        if (homeScreenController.loading &&
            homeScreenController.selectedBottomNavigationIndex == 0)
          const CircularProgressIndicator()
        else if (homeScreenController.selectedBottomNavigationIndex == 0)
          IconButton(
              onPressed: homeScreenController.getTermsUpdates,
              icon: homeScreenController.error
                  ? const Icon(Icons.warning)
                  : const Icon(Icons.refresh)),
        IconButton(
            onPressed: () => context.push(NotificationsScreen.route),
            icon: const Icon(NotificationsScreen.icon)),
        IconButton(
          icon: const Icon(SettingsScreen.icon),
          onPressed: () => context.push(SettingsScreen.route),
        )
      ],
      drawer: const DrawerWidget(),
      floatingActionButton:
          homeScreenController.selectedBottomNavigationIndex == 0
              ? FloatingActionButton.extended(
          key: addCouponKey,
          tooltip: EnterCouponScreen.title,
          heroTag: EnterCouponScreen.title,
          onPressed: () async {
            await context.push(EnterCouponScreen.route);
            // Get.find<TermsListingController>().fetch!();
            TermsListingController browseTermsTabController = Get.find();
            browseTermsTabController.init();
          },
          icon: const Icon(EnterCouponScreen.icon),
                  label: Text(EnterCouponScreen.title))
              : null,
      tabs: homeScreenController.selectedBottomNavigationIndex == 0
          ? [
        Tab(
          icon: const Icon(Icons.article),
          text: StringConstant.browseTerms.tr(),
        ),
        Tab(
          icon: const Icon(Icons.history),
          text: StringConstant.recentTerms.tr(),
        ),
        Tab(
          icon: const Icon(Icons.fiber_new),
          text: StringConstant.newTerms.tr(),
        ),
        Tab(
          icon: const Icon(Icons.fact_check_outlined),
          text: StringConstant.unstudied.tr(),
        ),
        Tab(
          icon: const Icon(Icons.update),
          text: StringConstant.updateable.tr(),
        ),
            ]
          : [],
      bottomNavigationBar: hasStore
          ? BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: const Icon(CupertinoIcons.book_solid),
                  label: StringConstant.educationalContent.tr(),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(CupertinoIcons.bag_fill),
                  label: StringConstant.store.tr(),
                ),
              ],
              currentIndex: homeScreenController.selectedBottomNavigationIndex,
              onTap: (index) {
                setState(() {
                  homeScreenController.selectedBottomNavigationIndex = index;
                });
              },
            )
          : null,
      child: homeScreenController.selectedBottomNavigationIndex == 0
          ? const TabBarView(children: [
              PopScope(canPop: false, child: BrowseTermsTab()),
              RecentTermsTab(),
              NewTermsTab(),
              UnstudiedTermsTab(),
              UpdateableTermsTab()
            ])
          : const PopScope(canPop: false, child: StoreTab()),
    );
  }
}
