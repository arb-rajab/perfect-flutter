import 'package:beta/domain/news.dart';
import 'package:beta/presentation/home/news_tab_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class NewsWidget extends StatelessWidget {
  final int index;
  const NewsWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    NewsTabController controller = Get.find();
    News news = controller.items[index];
    // Format the createdAt date nicely
    final formattedDate = DateFormat.yMMMMd().format(news.createdAt);

    return GestureDetector(
      onTap: () => controller.moveToNewsScreen(news),
      child: Semantics(
        label: '${news.title.value!}, $formattedDate',
        button: true,
        excludeSemantics: true,
        child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                news.title.value!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              // Content
              // Text(
              //   news.content.value!,
              //   style: const TextStyle(fontSize: 16),
              // ),

              // const SizedBox(height: 12),

              // Created At
              Text(
                formattedDate,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
