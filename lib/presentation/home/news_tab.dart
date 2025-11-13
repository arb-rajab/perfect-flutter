import 'package:beta/presentation/home/news_tab_controller.dart';
import 'package:beta/presentation/widgets/items_list.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class NewsTab extends StatefulWidget {
  const NewsTab({super.key});

  @override
  State<StatefulWidget> createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
  late NewsTabController controller;

  @override
  void initState() {
    Get.delete<NewsTabController>();
    controller = Get.put(NewsTabController(this));
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ItemsList(controller: controller);
}
