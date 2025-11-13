// ignore_for_file: invalid_use_of_protected_member

import 'package:beta/application/services/network_service.dart';
import 'package:beta/constants/api_constant.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/product.dart';
import 'package:beta/domain/value/id.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ProductScreenController {
  State state;
  Id id;
  bool loading = false;
  String message = '';
  Product? product;
  final ScrollController scrollController = ScrollController();
  Color titleBackgroundColor = Colors.white.withValues(alpha: 0.5);
  final CarouselSliderController carouselController =
      CarouselSliderController();
  int currentImageIndex = 0;

  ProductScreenController(this.state, this.id) {
    WidgetsBinding.instance.addPostFrameCallback((_) => getData());
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    double threshold = 200.0; // The expanded height of the SliverAppBar
    if (scrollController.hasClients) {
      double currentOffset = scrollController.offset;
      state.setState(() {
        titleBackgroundColor = currentOffset < threshold
            ? Colors.white.withValues(alpha: 0.5)
            : Colors.transparent;
      });
    }
  }

  void dispose() => scrollController.dispose();

  Future getData() => NetworkService(onPreConnect: () {
        if (state.mounted) {
          state.setState(() {
            loading = true;
            message = '';
          });
        }
      }, onPostConnect: () {
        if (state.mounted) {
          state.setState(() {
            loading = false;
            message = '';
          });
        }
      }, onConnectionSucceed: (data) {
        if (state.mounted) {
          state.setState(() => product = Product.fromJson(data['product']));
        }
        return Future.value();
      }, onConnectionFailed: () {
        if (state.mounted) {
          state.setState(() => message = StringConstant.noConnection.tr());
        }
      }, onMessageReceived: (failureResponse) {
        if (state.mounted) {
          state.setState(() => message = failureResponse.content);
        }
      }).get(
          url: ApiConstant.product
              .replaceFirst('(PRODUCT_ID)', id.value!.toString()));
}
