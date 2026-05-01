import 'package:beta/presentation/images/images_screen_controller.dart';
import 'package:beta/presentation/widgets/loading_widget.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class ImagesScreen extends StatefulWidget {
  static const String route = '/images';
  const ImagesScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> {
  late ImagesScreenController controller;

  @override
  void initState() {
    Get.delete<ImagesScreenController>();
    controller = Get.put(ImagesScreenController(this));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      titleText: controller.argument.title,
      child: ListView.builder(
        itemCount: controller.images.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: ExpansionTile(
              // Wrap image in GestureDetector for zoom/fullscreen functionality
              title: GestureDetector(
                onTap: () => controller.showFullScreenImage(
                  controller.images[index].image.url,
                ),
                child: CachedNetworkImage(
                  imageUrl: controller.images[index].image.url,
                  placeholder: (context, url) =>
                      const SizedBox(height: 200, child: LoadingWidget()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.images[index].image.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(controller.images[index].image.info),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
