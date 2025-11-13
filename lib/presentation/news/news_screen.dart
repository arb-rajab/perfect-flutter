import 'package:beta/domain/news.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/presentation/news/news_screen_controller.dart';
import 'package:beta/presentation/widgets/loading_widget.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_table/flutter_html_table.dart';
import 'package:get/instance_manager.dart';

class NewsScreen extends StatefulWidget {
  static const String route = '/news/:newsId';
  final Id id;

  const NewsScreen({super.key, required this.id});

  @override
  State<StatefulWidget> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late NewsScreenController controller;
  @override
  void initState() {
    Get.delete<NewsScreenController>();
    controller = Get.put(NewsScreenController(this, widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (controller.loading) {
      return const LoadingWidget();
    }
    if (controller.message.isNotEmpty) {
      return Center(
        child: Text(controller.message),
      );
    }
    if (controller.news == null) return const Center();

    News news = controller.news!;
    final formattedDate = DateFormat.yMMMMd().format(news.createdAt);

    return ScreenWrapper(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        news.title.value.toString(),
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        formattedDate,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Html(
                          data: news.content.value!,
                          extensions: const [
                            // for supporting tables
                            TableHtmlExtension(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
