// ignore_for_file: invalid_use_of_protected_member

import 'package:beta/application/services/network_service.dart';
import 'package:beta/constants/api_constant.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/product.dart';
import 'package:beta/domain/product_type.dart';
import 'package:beta/domain/value/product_type_id.dart';
import 'package:beta/helper/failure_response.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class StoreTabController {
  State state;
  bool loading = false;
  String message = '';
  ProductTypeId? typeId;
  List<Product> latestProducts = [];
  List<Product> mostSeenProducts = [];
  List<Product> offers = [];
  List<Product> products = [];
  List<Product> newProducts = [];
  List<ProductType> productTypes = [];
  List<String> listingApis = [];
  List<ProductTypeId?> typeIds = [];

  StoreTabController(this.state) {
    WidgetsBinding.instance.addPostFrameCallback((_) => getData());
  }

  void onPreConnect() => state.setState(() {
        loading = true;
        message = '';
      });

  void onPostConnect() => state.setState(() {
        loading = false;
        message = '';
      });

  void onConnectionFailed() => state.setState(() {
        message = StringConstant.noConnection.tr();
      });

  void onMessageRecieved(FailureResponse response) => state.setState(() {
        message = response.content;
      });

  void clearData() {
    latestProducts.clear();
    offers.clear();
    mostSeenProducts.clear();
    products.clear();
    productTypes.clear();
  }

  Future getData({String api = ApiConstant.products}) =>
      NetworkService(
              onPreConnect: onPreConnect,
              onPostConnect: onPostConnect, onConnectionSucceed: (data) {
        state.setState(() {
          if (listingApis.isEmpty || listingApis.last != api) {
            clearData();
            listingApis.add(api);
            typeIds.add(typeId);
          }
          if (data['latest-products'] != null) {
            latestProducts = (data['latest-products'] as List)
                .map(Product.fromJson)
                .toList();
          }
          if (data['offers'] != null) {
            offers = (data['offers'] as List).map(Product.fromJson).toList();
          }
          if (data['most-seen-products'] != null) {
            mostSeenProducts = (data['most-seen-products'] as List)
                .map(Product.fromJson)
                .toList();
          }
          if (data['product-types'] != null) {
            productTypes = (data['product-types'] as List)
                .map(ProductType.fromJson)
                .toList();
          }
          if (data['products'] != null) {
            newProducts =
                (data['products'] as List).map(Product.fromJson).toList();
            if (latestProducts.isEmpty &&
                productTypes.isEmpty &&
                mostSeenProducts.isEmpty &&
                offers.isEmpty) {
              products.addAll(newProducts);
            } else {
              products = [...newProducts];
            }
          }
        });
            return Future.value();
      },
              onConnectionFailed: onConnectionFailed,
              onMessageReceived: onMessageRecieved)
          .get(url: api);

  bool canPop() => listingApis.length < 2;

  void onPopInvoked(bool didPop, result) {
    if (didPop) return;
    listingApis.removeLast();
    typeIds.removeLast();
    typeId = typeIds.last;
    getData(api: listingApis.last);
  }
}
