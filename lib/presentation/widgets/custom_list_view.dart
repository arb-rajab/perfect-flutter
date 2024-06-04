import 'package:beta/presentation/widgets/screen_wrapper_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class CustomListView extends StatelessWidget {
  final List<Widget> children;
  final ScrollPhysics? physics;

  const CustomListView({super.key, required this.children, this.physics});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: physics,
      controller: Get.find<ScreenWrapperController>(
              tag: ModalRoute.of(context)!.settings.name!)
          .scrollController,
      children: children,
    );
  }
}
