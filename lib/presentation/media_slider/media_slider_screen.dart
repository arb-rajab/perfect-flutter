import 'package:beta/presentation/media_slider/media_widget.dart';
import 'package:beta/presentation/media_slider/media_slider_controller.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class MediaSliderScreen extends StatefulWidget {
  static const String route = '/medias';
  const MediaSliderScreen({super.key});

  @override
  State<MediaSliderScreen> createState() => _MediaSliderScreenState();
}

class _MediaSliderScreenState extends State<MediaSliderScreen> {
  late MediaSliderController mediaSliderController;
  @override
  void initState() {
    Get.delete<MediaSliderController>();
    mediaSliderController = Get.put(MediaSliderController(this));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
        titleText:
            "${mediaSliderController.page + 1}/${mediaSliderController.mediaSlidersScreenArgument.mediaUrls.length}",
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: mediaSliderController.pageController,
                itemCount: mediaSliderController
                    .mediaSlidersScreenArgument.mediaUrls.length,
                itemBuilder: (context, index) {
                  return MediaWidget(
                      url: mediaSliderController
                          .mediaSlidersScreenArgument.mediaUrls[index]);
                },
                onPageChanged: mediaSliderController.onPageChanged,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    key: const Key('prev_button'),
                    icon: const Icon(Icons.arrow_back),
                    onPressed: mediaSliderController.previousButtonEnabled()
                        ? mediaSliderController.goToPreviousPage
                        : null),
                IconButton(
                    key: const Key('next_button'),
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: mediaSliderController.nextButtonEnabled()
                        ? mediaSliderController.goToNextPage
                        : null),
              ],
            ),
          ],
        ));
  }
}
