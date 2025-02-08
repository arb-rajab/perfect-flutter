import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/product.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/presentation/product/product_screen_controller.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class ProductScreen extends StatefulWidget {
  static const String route = '/products/:productId';
  final Id id;

  const ProductScreen({super.key, required this.id});

  @override
  State<StatefulWidget> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late ProductScreenController controller;
  @override
  void initState() {
    Get.delete<ProductScreenController>();
    controller = Get.put(ProductScreenController(this, widget.id));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (controller.message.isNotEmpty) {
      return Center(
        child: Text(controller.message),
      );
    }
    if (controller.product == null) return const Center();
    Product product = controller.product!;
    return ScreenWrapper(
      child: CustomScrollView(
        controller: controller.scrollController,
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Container(
                color: controller.titleBackgroundColor,
                child: Text(
                  product.name.value.toString(),
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: product.imageUrl,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black54],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 10.0),
                      Text(
                        product.description!.value!,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            StringConstant.price.tr(),
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            product.price.value.toString(),
                            style: const TextStyle(
                                fontSize: 18.0, color: Colors.red),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            StringConstant.createdOn.tr(),
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${product.createdAt!.year}-${product.createdAt!.month}-${product.createdAt!.day}',
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
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
