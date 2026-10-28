// ignore_for_file: invalid_use_of_protected_member

import 'package:beta/application/services/image_service.dart';
import 'package:beta/application/services/term_last_access_service.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/domain/image_data.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/infrastructure/screenshot/shared.dart';
import 'package:beta/presentation/media_slider/media_slider_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';

class ImagesScreenController {
  final State state;
  final ImagesScreenArgument argument = Get.find();
  final ScreenshotRepository screenshotRepository = Get.find();
  final ImageService imageService = Get.find();
  List<ImageData> images = [];
  int currentIndex = 0;

  ImagesScreenController(this.state) {
    _configureScreenshots();
    _configureImages();
  }

  Future _configureImages() async {
    images = (await imageService.getImagesFromQuery(
      argument.query,
    )).map((element) => ImageData(element)).toList();
    state.setState(() {});
  }

  void _configureScreenshots() {
    screenshotRepository.setScreenshotPolicy(this,
        prevent: argument.term.term.captureable == 0);
  }

  void toggleDetails(int imageIndex) {
    state.setState(() {
      images[imageIndex].isFront = !images[imageIndex].isFront;
    });
  }

  Future<void> dispose() async {
    await screenshotRepository.releaseScreenshotPolicy(this);
    TermLastAccessService termLastAccessService = Get.find();
    return termLastAccessService.addTermLastAccessed(
      Id(argument.term.term.id),
      1,
    );
  }

  void showFullScreenImage(String imageUrl) {
    Get.delete<MediaSliderScreenArgument>();
    Get.put(MediaSliderScreenArgument(mediaUrls: [imageUrl]));
    state.context.push(MediaSliderScreen.route);
  }
}
