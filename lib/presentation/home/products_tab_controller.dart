import 'package:beta/constants/api_constant.dart';
import 'package:beta/domain/product.dart';
import 'package:beta/presentation/home/product_widget.dart';
import 'package:beta/presentation/widgets/list_controller.dart';
import 'package:flutter/material.dart';

class ProductsTabController extends ListController<Product> {
  ProductsTabController(state, products)
      : super(
            itemBuilder: (context, index) => const Center(),
            state: state,
            plural: 'products',
            remote: false,
            indexUrl: ApiConstant.products,
            itemsPerRow: 2,
            fetch: () => Future.value(products),
            fromJson: Product.fromJson);

  @override
  Widget Function(BuildContext p1, int p2) get itemBuilder => (context, index) {
        Product product = items[index];
        return ProductWidget(
          product: product,
        );
      };
}
