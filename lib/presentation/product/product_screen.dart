import 'package:beta/constants/arguments.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/product.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/presentation/media_slider/media_slider_screen.dart';
import 'package:beta/presentation/product/product_screen_controller.dart';
import 'package:beta/presentation/widgets/loading_widget.dart';
import 'package:beta/presentation/widgets/product_price.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_html_table/flutter_html_table.dart';
import 'package:get/instance_manager.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_html/flutter_html.dart';

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
    List<String> imageUrls = [product.imageUrl, ...product.images!];

    return ScreenWrapper(
      child: CustomScrollView(
        controller: controller.scrollController,
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.delete<MediaSliderScreenArgument>();
                      Get.put(MediaSliderScreenArgument(mediaUrls: imageUrls));
                      context.push(MediaSliderScreen.route);
                    },
                    child: CarouselSlider(
                      carouselController: controller.carouselController,
                      items: imageUrls.map((url) {
                        return CachedNetworkImage(
                          imageUrl: url,
                          placeholder: (context, url) =>
                              const LoadingWidget(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.cover,
                        );
                      }).toList(),
                      options: CarouselOptions(
                        height: 300,
                        viewportFraction: 1.0,
                        enlargeCenterPage: false,
                        onPageChanged: (index, reason) {
                          setState(() {
                            controller.currentImageIndex = index;
                          });
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: imageUrls.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => controller.carouselController
                              .animateToPage(entry.key),
                          child: Container(
                            width: 8.0,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black)
                                  .withValues(
                                      alpha: controller.currentImageIndex ==
                                              entry.key
                                          ? 0.9
                                          : 0.4),
                            ),
                          ),
                        );
                      }).toList(),
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
                    children: <Widget>[
                      Text(
                        product.name.value.toString(),
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      // SingleChildScrollView(
                      //   scrollDirection: Axis.horizontal,
                      //   child:
                      if (product.descriptionRtl != null &&
                          product.descriptionRtl!.value != null)
                        Column(
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Html(
                                data: product.descriptionRtl!.value!,
                                shrinkWrap: true,
                                extensions: const [
                                  // for supporting tables
                                  TableHtmlExtension(),
                                ],
                                // ),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                          ],
                        ),
                      if (product.descriptionLtr != null &&
                          product.descriptionLtr!.value != null)
                        Column(
                          children: [
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: Html(
                                data: product.descriptionLtr!.value!,
                                shrinkWrap: true,
                                extensions: const [
                                  // for supporting tables
                                  TableHtmlExtension(),
                                ],
                                // ),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                          ],
                        ),
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
                          ProductPrice(
                            product: product,
                          )
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      if (product.singlePrice.value != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              StringConstant.singlePrice.tr(),
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${product.singlePrice.value}',
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.red,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' ${product.unit.name}',
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: <Widget>[
                      //     Text(
                      //       StringConstant.createdOn.tr(),
                      //       style: const TextStyle(
                      //         fontSize: 18.0,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //     Text(
                      //       '${product.createdAt!.year}-${product.createdAt!.month}-${product.createdAt!.day}',
                      //       style: const TextStyle(
                      //         fontSize: 16.0,
                      //       ),
                      //     ),
                      //   ],
                      // ),
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
