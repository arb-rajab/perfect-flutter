import 'package:beta/constants/api_constant.dart';
import 'package:beta/constants/key_value_constant.dart';
import 'package:beta/domain/news.dart';
import 'package:beta/infrastructure/key_value_repository.dart';
import 'package:beta/presentation/home/home_screen_controller.dart';
import 'package:beta/presentation/home/news_widget.dart';
import 'package:beta/presentation/news/news_screen.dart';
import 'package:beta/presentation/widgets/list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';

class NewsTabController extends ListController<News> {
  NewsTabController(state)
      : super(
            itemBuilder: (context, index) => NewsWidget(index: index),
            state: state,
            plural: 'news',
            fetch: null,
            fromJson: News.fromJson,
            indexUrl: ApiConstant.news) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      removeNewNewsBadge();
    });
  }

  Future removeNewNewsBadge() async {
    KeyValue keyValue = Get.find();
    keyValue.setBool(KeyValueConstant.newsRecieved, false);
    HomeScreenController homeScreenController = Get.find();
    if (homeScreenController.state.mounted) {
      homeScreenController.state
        // ignore: invalid_use_of_protected_member
        .setState(() => homeScreenController.newNews = false);
    }
  }

  void moveToNewsScreen(News news) => state.context.push(
      NewsScreen.route.replaceFirst(':newsId', news.id.value!.toString()));
}
