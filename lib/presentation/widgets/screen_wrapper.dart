import 'package:beta/application/services/tutorial_service.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/main_controller.dart';
import 'package:beta/presentation/widgets/screen_wrapper_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class ScreenWrapper extends StatefulWidget {
  final Widget child;
  final String? titleText;
  final Widget? title;
  final IconData? icon;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final List<TargetFocus> targets;
  final List<Tab> tabs;

  const ScreenWrapper(
      {super.key,
      required this.child,
      this.titleText,
      this.title,
      this.bottomNavigationBar,
      this.icon,
      this.actions,
      this.drawer,
      this.floatingActionButton,
      this.targets = const [],
      this.tabs = const []});

  @override
  State<ScreenWrapper> createState() => _ScreenWrapperState();
}

class _ScreenWrapperState extends State<ScreenWrapper> {
  late ScreenWrapperController _controller;
  late TutorialService _tutorialService;
  late List<TargetFocus> _targets;
  late String tag;
  @override
  void initState() {
    _tutorialService = Get.find();
    _targets = widget.targets
        .where((element) =>
            !_tutorialService.isTutorialDismissed(element.identify.toString()))
        .toList();
    Future.delayed(Duration.zero, showTutorial);
    super.initState();
  }

  void showTutorial() {
    if (_targets.isNotEmpty && !MainController.testing) {
      TutorialCoachMark(
          targets: _targets,
          colorShadow: Theme.of(context).primaryColorDark,
          textSkip: StringConstant.skip.tr(),
          textStyleSkip:
              TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
          onClickTarget: (targetFocus) =>
              _tutorialService.dismissTutorial(targetFocus.identify),
          onClickOverlay: (targetFocus) =>
              _tutorialService.dismissTutorial(targetFocus.identify),
          onSkip: () {
            for (TargetFocus targetFocus in _targets) {
              _tutorialService.dismissTutorial(targetFocus.identify);
            }
            return false;
          }
          // alignSkip: Alignment.bottomRight,
          // paddingFocus: 10,
          // focusAnimationDuration: Duration(milliseconds: 500),
          // unFocusAnimationDuration: Duration(milliseconds: 500),
          // pulseAnimationDuration: Duration(milliseconds: 500),
          // pulseVariation: Tween(begin: 1.0, end: 0.99),
          // showSkipInLastTarget: true,
          // imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          // initialFocus: 0,
          // useSafeArea: true,
          // onFinish: () {
          //   print("finish");
          // },
          // onClickTargetWithTapPosition: (target, tapDetails) {
          //   print("target: $target");
          //   print(
          //       "clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
          // },
          ).show(context: context);
    }

    // tutorial.skip();
    // tutorial.finish();
    // tutorial.next(); // call next target programmatically
    // tutorial.previous(); // call previous target programmatically
    // tutorial.goTo(3); // call target programmatically by index
  }

  @override
  void dispose() {
    Get.delete<ScreenWrapperController>(tag: tag);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    tag = ModalRoute.of(context)!.settings.name!;
    _controller = Get.isRegistered<ScreenWrapperController>(tag: tag)
        ? Get.find(tag: tag)
        : Get.put(ScreenWrapperController(this), tag: tag);
    return SafeArea(
        child: DefaultTabController(
      length: widget.tabs.length,
      child: Scaffold(
          drawer: widget.drawer,
          appBar: widget.titleText != null ||
                  widget.title != null ||
                  widget.drawer != null ||
                  widget.actions != null
              ? AppBar(
                  actions: widget.actions,
                  leading: widget.icon != null ? Icon(widget.icon) : null,
                  title: widget.titleText != null
                      ? Hero(
                          tag: widget.titleText!,
                          child: Text(widget.titleText!),
                        )
                      : widget.title,
                  bottom: widget.tabs.isNotEmpty
                      ? TabBar(
                          isScrollable: true,
                          tabs: widget.tabs,
                        )
                      : null,
                )
              : null,
          body: widget.child,
          bottomNavigationBar: widget.bottomNavigationBar,
          floatingActionButton:
              _controller.isVisible ? widget.floatingActionButton : null,
          floatingActionButtonLocation: widget.bottomNavigationBar != null
              ? FloatingActionButtonLocation.miniCenterDocked
              : FloatingActionButtonLocation.endFloat),
    ));
  }
}

class CustomTargetFocus extends TargetFocus {
  @override
  bool get enableOverlayTab => true;

  CustomTargetFocus({
    super.identify,
    super.keyTarget,
    super.contents,
  });
}
