// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScreenWrapperController {
  bool isVisible = true;
  final ScrollController scrollController = ScrollController();
  State state;

  ScreenWrapperController(this.state) {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (isVisible && state.mounted) {
          state.setState(() {
            isVisible = false;
          });
        }
      } else if (!isVisible) {
        if (state.mounted) {
          state.setState(() {
            isVisible = true;
          });
        }
      }
    });
  }
}
