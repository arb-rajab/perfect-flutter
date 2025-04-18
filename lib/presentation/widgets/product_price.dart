import 'package:beta/domain/product.dart';
import 'package:flutter/material.dart';

class ProductPrice extends StatelessWidget {
  final Product product;

  const ProductPrice({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          if (product.offerPrice.value != null)
            TextSpan(
              text: '${product.price.value} ',
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          TextSpan(
            text: '${product.offerPrice.value ?? product.price.value}',
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
    );
  }
}
