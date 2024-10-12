// ignore_for_file: invalid_use_of_protected_member

import 'package:beta/application/services/flashcard_service.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/domain/flashcard_data.dart';
import 'package:beta/infrastructure/screenshot_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class FlashcardsScreenController {
  final State state;
  final FlashcardsScreenArgument argument = Get.find();
  final ScreenshotRepository screenshotRepository = Get.find();
  final FlashcardService flashcardService = Get.find();
  List<FlashcardData> flashcards = [];
  int currentIndex = 0;
  final PageController pageController = PageController(viewportFraction: 0.8);

  FlashcardsScreenController(this.state) {
    _configureScreenshots();
    _configureFlashcards();
  }

  Future _configureFlashcards() async {
    flashcards = (await flashcardService.getFlashcardsFromQuery(argument.query))
        .map((element) => FlashcardData(element))
        .toList();
    state.setState(() {});
  }

  void _configureScreenshots() {
    if (argument.term.term.captureable == 0) {
      screenshotRepository.preventScreenshot();
    } else {
      screenshotRepository.allowScreenshot();
    }
  }

  void flipCard(int flashcardIndex) {
    state.setState(() {
      flashcards[flashcardIndex].isFront = !flashcards[flashcardIndex].isFront;
    });
  }

  void nextFlashcard() {
    state.setState(() {
      if (currentIndex < flashcards.length - 1) {
        currentIndex++;
        flashcards[currentIndex].isFront = true;
      }
    });
    pageController.jumpToPage(currentIndex);
  }

  void previousFlashcard() {
    state.setState(() {
      if (currentIndex > 0) {
        currentIndex--;
        flashcards[currentIndex].isFront = true;
      }
    });
    pageController.jumpToPage(currentIndex);
  }

  void onPageChanged(int value) => state.setState(() {
        currentIndex = value;
        flashcards[value].isFront = true;
      });

  bool previousButtonVisible() => currentIndex > 0;

  bool nextFlashcardVisible() => currentIndex < flashcards.length - 1;
}
