import 'package:beta/configs/app.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/constants/tutorial_constant.dart';
import 'package:beta/presentation/enter_coupon/enter_coupon_screen.dart';
import 'package:beta/presentation/home/browse_terms_tab.dart';
import 'package:beta/presentation/home/drawer_widget.dart';
import 'package:beta/presentation/home/home_screen_controller.dart';
import 'package:beta/presentation/home/new_terms_tab.dart';
import 'package:beta/presentation/home/news_tab.dart';
import 'package:beta/presentation/home/recent_terms_tab.dart';
import 'package:beta/presentation/home/store_tab.dart';
import 'package:beta/presentation/home/term_updates_banner.dart';
import 'package:beta/presentation/home/terms_listing_controller.dart';
import 'package:beta/presentation/home/unstudied_terms_tab.dart';
import 'package:beta/presentation/home/favorite_terms_tab.dart';
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
import 'package:upgrader/upgrader.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey addCouponKey = GlobalKey();
  final GlobalKey browseTermsKey = GlobalKey();
  final GlobalKey recentTermsKey = GlobalKey();
  final GlobalKey newTermsKey = GlobalKey();
  final GlobalKey unstudiedTermsKey = GlobalKey();
  final GlobalKey favoriteTermsKey = GlobalKey();
  final GlobalKey updateableTermsKey = GlobalKey();

  late HomeScreenController homeScreenController;

  @override
  void initState() {
    super.initState();
    Get.delete<HomeScreenController>();
    homeScreenController = Get.put(HomeScreenController(this));
  }

  void _openEducationalMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) => _buildEducationalMenuSheet(context),
    );
  }

  Widget _buildEducationalMenuSheet(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.menu_book, size: 28),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      StringConstant.educationalContent.tr(),
                      style: Theme.of(context).textTheme.titleLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            _buildMenuTile(
              Icons.article,
              StringConstant.browseTerms.tr(),
              0,
              browseTermsKey,
            ),
            _buildMenuTile(
              Icons.history,
              StringConstant.recentTerms.tr(),
              1,
              recentTermsKey,
            ),
            _buildMenuTile(
              Icons.fiber_new,
              StringConstant.newTerms.tr(),
              2,
              newTermsKey,
            ),
            _buildMenuTile(
              Icons.fact_check_outlined,
              StringConstant.unstudied.tr(),
              3,
              unstudiedTermsKey,
            ),
            _buildMenuTile(
              Icons.star,
              StringConstant.favorite.tr(),
              4,
              favoriteTermsKey,
            ),
            _buildMenuTile(
              Icons.update,
              StringConstant.updateable.tr(),
              HomeScreenController.updateableTabIndex,
              updateableTermsKey,
              badgeCount: homeScreenController.updateableTermsCount,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuTile(IconData icon, String text, int index, GlobalKey key,
      {int badgeCount = 0}) {
    final isSelected = homeScreenController.educationalIndex == index;

    return ListTile(
      key: key,
      leading: Badge(
        isLabelVisible: badgeCount > 0,
        label: Text(badgeCount.toString()),
        child: Icon(
          icon,
          color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
        ),
      ),
      title: Text(
        text,
        style: TextStyle(
          color: isSelected ? Theme.of(context).primaryColor : null,
          fontWeight: isSelected ? FontWeight.bold : null,
        ),
      ),
      selected: isSelected,
      onTap: () {
        setState(() {
          homeScreenController.educationalIndex = index;
        });
        Navigator.pop(context);
      },
    );
  }

  String _getSelectedTabTitle() {
    switch (homeScreenController.educationalIndex) {
      case 0:
        return StringConstant.browseTerms.tr();
      case 1:
        return StringConstant.recentTerms.tr();
      case 2:
        return StringConstant.newTerms.tr();
      case 3:
        return StringConstant.unstudied.tr();
      case 4:
        return StringConstant.favorite.tr();
      case 5:
        return StringConstant.updateable.tr();
      default:
        return StringConstant.browseTerms.tr();
    }
  }

  Widget _educationalContent(int index) {
    switch (index) {
      case 0:
        return const BrowseTermsTab();
      case 1:
        return const RecentTermsTab();
      case 2:
        return const NewTermsTab();
      case 3:
        return const UnstudiedTermsTab();
      case 4:
        return const FavoriteTermsTab();
      case 5:
        return const UpdateableTermsTab();
      default:
        return const BrowseTermsTab();
    }
  }

  bool _onUpdateableTab() =>
      homeScreenController.educationalIndex ==
      HomeScreenController.updateableTabIndex;

  bool _showUpdatesBanner() =>
      homeScreenController.updateableTermsCount > 0 &&
      (_onUpdateableTab() || !homeScreenController.updatesBannerDismissed);

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      title: homeScreenController.selectedBottomNavigationIndex == 0
          ? InkWell(
              onTap: _openEducationalMenu,
              child: Row(
                children: [
                  Badge(
                    isLabelVisible:
                        homeScreenController.updateableTermsCount > 0,
                    label: Text(
                        homeScreenController.updateableTermsCount.toString()),
                    child: const Icon(Icons.arrow_downward),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _getSelectedTabTitle(),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            )
          : null,
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
            ]),
        CustomTargetFocus(
            identify: TutorialConstant.browseTerms,
            keyTarget: browseTermsKey,
            contents: [
              TargetContent(
                  builder: (context, controller) {
                    return RectangleWidget(
                  child: Text(StringConstant.browseTermsExplanation.tr()),
                );
                  },
                  align: ContentAlign.bottom)
            ]),
        CustomTargetFocus(
            identify: TutorialConstant.recentTerms,
            keyTarget: recentTermsKey,
            contents: [
              TargetContent(
                  builder: (context, controller) {
                    return RectangleWidget(
                  child: Text(StringConstant.recentTermsExplanation.tr()),
                );
                  },
                  align: ContentAlign.bottom)
            ]),
        CustomTargetFocus(
            identify: TutorialConstant.newTerms,
            keyTarget: newTermsKey,
            contents: [
              TargetContent(
                  builder: (context, controller) {
                    return RectangleWidget(
                        child: Text(StringConstant.newTermsExplanation.tr()));
                  },
                  align: ContentAlign.bottom)
            ]),
        CustomTargetFocus(
            identify: TutorialConstant.unstudiedTerms,
            keyTarget: unstudiedTermsKey,
            contents: [
              TargetContent(
                  builder: (context, controller) {
                    return RectangleWidget(
                  child: Text(StringConstant.unstudiedTermsExplanation.tr()),
                );
                  },
                  align: ContentAlign.bottom)
            ]),
        CustomTargetFocus(
            identify: TutorialConstant.favoriteTerms,
            keyTarget: favoriteTermsKey,
            contents: [
              TargetContent(
                  builder: (context, controller) {
                    return RectangleWidget(
                  child: Text(StringConstant.favoriteTermsExplanation.tr()),
                );
                  },
                  align: ContentAlign.bottom),
            ]),
        CustomTargetFocus(
            identify: TutorialConstant.updateableTerms,
            keyTarget: updateableTermsKey,
            contents: [
              TargetContent(
                  builder: (context, controller) {
                    return RectangleWidget(
                  child: Text(StringConstant.updateableTermsExplanation.tr()),
                );
                  },
                  align: ContentAlign.bottom)
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
                    TermsListingController browseTermsTabController =
                        Get.find();
                    browseTermsTabController.init();
                  },
                  icon: const Icon(EnterCouponScreen.icon),
                  label: Text(EnterCouponScreen.title))
          : null,
      bottomNavigationBar: hasStore || hasNews
          ? BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: const Icon(CupertinoIcons.book_solid),
                  label: StringConstant.educationalContent.tr(),
                ),
                if (hasStore)
                  BottomNavigationBarItem(
                    icon: const Icon(CupertinoIcons.bag_fill),
                    label: StringConstant.store.tr(),
                  ),
                if (hasNews)
                  BottomNavigationBarItem(
                    icon: homeScreenController.newNews
                        ? Badge(
                            label: Text(StringConstant.neww.tr()),
                            child: const Icon(CupertinoIcons.news),
                          )
                        : const Icon(CupertinoIcons.news),
                    label: StringConstant.news.tr(),
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
          ? UpgradeAlert(
              child: Column(
                children: [
                  if (_showUpdatesBanner())
                    TermUpdatesBanner(
                      homeScreenController,
                      dismissible: !_onUpdateableTab(),
                    ),
                  Expanded(
                    child: _educationalContent(
                        homeScreenController.educationalIndex),
                  ),
                ],
              ),
            )
          : homeScreenController.selectedBottomNavigationIndex == 1 && hasStore
              ? const StoreTab()
              : const NewsTab(),
    );
  }
}
