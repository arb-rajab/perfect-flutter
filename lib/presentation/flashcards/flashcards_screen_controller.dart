// ignore_for_file: invalid_use_of_protected_member

import 'package:beta/application/services/flashcard_service.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/domain/flashcard_data.dart';
import 'package:beta/infrastructure/screenshot/shared.dart';
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

  bool searchVisible = false;
  String search = '';
  final TextEditingController searchController = TextEditingController();

  FlashcardsScreenController(this.state) {
    _configureScreenshots();
    _configureFlashcards();
  }

  List<FlashcardData> get displayedFlashcards => search.isEmpty
      ? flashcards
      : flashcards.where(_matchesSearch).toList();

  bool _matchesSearch(FlashcardData flashcardData) {
    final query = search.toLowerCase();
    final head = flashcardData.flashcard.head.toLowerCase();
    final tail = flashcardData.flashcard.tail
        .replaceAll(RegExp(r'<[^>]*>'), ' ')
        .toLowerCase();
    return head.contains(query) || tail.contains(query);
  }

  Future _configureFlashcards() async {
    flashcards = (await flashcardService.getFlashcardsFromQuery(argument.query))
        .map((element) => FlashcardData(element))
        .toList();
    state.setState(() {});
  }

  void _configureScreenshots() {
    screenshotRepository.setScreenshotPolicy(this,
        prevent: argument.term.term.captureable == 0);
  }

  void dispose() => screenshotRepository.releaseScreenshotPolicy(this);

  void flipCard(int flashcardIndex) {
    state.setState(() {
      displayedFlashcards[flashcardIndex].isFront =
          !displayedFlashcards[flashcardIndex].isFront;
    });
  }

  void nextFlashcard() {
    state.setState(() {
      if (currentIndex < displayedFlashcards.length - 1) {
        currentIndex++;
        displayedFlashcards[currentIndex].isFront = true;
      }
    });
    pageController.jumpToPage(currentIndex);
  }

  void previousFlashcard() {
    state.setState(() {
      if (currentIndex > 0) {
        currentIndex--;
        displayedFlashcards[currentIndex].isFront = true;
      }
    });
    pageController.jumpToPage(currentIndex);
  }

  void onPageChanged(int value) => state.setState(() {
        currentIndex = value;
        displayedFlashcards[value].isFront = true;
      });

  bool previousButtonVisible() => currentIndex > 0;

  bool nextFlashcardVisible() => currentIndex < displayedFlashcards.length - 1;

  void searchText(String? text) {
    if (text == null) return;
    state.setState(() {
      search = text;
      currentIndex = 0;
      if (displayedFlashcards.isNotEmpty) {
        displayedFlashcards.first.isFront = true;
      }
    });
    if (pageController.hasClients && displayedFlashcards.isNotEmpty) {
      pageController.jumpToPage(0);
    }
  }

  void clearSearch() {
    state.setState(() {
      search = '';
      searchVisible = false;
      currentIndex = 0;
      if (displayedFlashcards.isNotEmpty) {
        displayedFlashcards.first.isFront = true;
      }
    });
    searchController.clear();
    if (pageController.hasClients && displayedFlashcards.isNotEmpty) {
      pageController.jumpToPage(0);
    }
  }

  void setSearchVisible(bool value) {
    state.setState(() {
      searchVisible = value;
    });
  }
}
