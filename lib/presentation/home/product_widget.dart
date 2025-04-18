import 'package:beta/domain/product.dart';
import 'package:beta/presentation/product/product_screen.dart';
import 'package:beta/presentation/widgets/product_price.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductWidget extends StatelessWidget {
  final Product product;
  const ProductWidget({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(ProductScreen.route
          .replaceFirst(':productId', product.id.value!.toString())),
      child: Card(
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: product.imageUrl,
              height: 200,
              width: 150,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Text(product.name.value!),
            ProductPrice(product: product)
          ],
        ),
      ),
    );
  }
}
