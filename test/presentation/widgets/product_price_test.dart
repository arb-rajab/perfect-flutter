import 'package:beta/domain/product.dart';
import 'package:beta/domain/value/price.dart';
import 'package:beta/domain/value/unit.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/title.dart' as t;
import 'package:beta/presentation/widgets/product_price.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:beta/constants/string_constant.dart';

import '../../common/tests.dart';

Future main() async {
  await initTests();
  group('ProductPrice Widget Tests', () {
    // Test data
    const mockUnit = Unit(2); // 2 represents SYP
    const mockPrice = Price(10000);
    const mockOfferPrice = Price(8000);
    const mockId = Id(1);
    const mockTitle = t.Title('Test Product');
    const mockImageUrl = 'https://example.com/image.jpg';

    Product createTestProduct({
      Price? price,
      Price? offerPrice,
      Unit? unit,
    }) {
      return Product(
        id: mockId,
        name: mockTitle,
        imageUrl: mockImageUrl,
        price: price ?? mockPrice,
        offerPrice: offerPrice ?? const Price(null),
        unit: unit ?? mockUnit,
      );
    }

    List<InlineSpan> getTextSpans(RichText richText) {
      final textSpan = richText.text as TextSpan;
      return textSpan.children ?? [];
    }

    testWidgets('displays regular price when no offer price', (tester) async {
      final product = createTestProduct();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductPrice(product: product),
          ),
        ),
      );

      // Verify price is displayed
      expect(find.textContaining('10000', findRichText: true), findsOneWidget);
      expect(find.textContaining(StringConstant.syp, findRichText: true),
          findsOneWidget);

      // Verify only two text spans (price + unit)
      final richText = tester.widget<RichText>(find.byType(RichText));
      expect(getTextSpans(richText).length, 2);
    });

    testWidgets('displays both prices when offer exists', (tester) async {
      final product = createTestProduct(offerPrice: mockOfferPrice);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductPrice(product: product),
          ),
        ),
      );

      // Verify both prices are displayed
      expect(find.textContaining('10000', findRichText: true), findsOneWidget);
      expect(find.textContaining('8000', findRichText: true), findsOneWidget);
      expect(find.textContaining(StringConstant.syp, findRichText: true),
          findsOneWidget);

      // Verify three text spans (original price + offer price + unit)
      final richText = tester.widget<RichText>(find.byType(RichText));
      expect(getTextSpans(richText).length, 3);
    });

    testWidgets('applies correct text styles', (tester) async {
      final product = createTestProduct(offerPrice: mockOfferPrice);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductPrice(product: product),
          ),
        ),
      );

      final richText = tester.widget<RichText>(find.byType(RichText));
      final textSpans = getTextSpans(richText);

      // Original price style
      final originalPriceStyle = (textSpans[0] as TextSpan).style;
      expect(originalPriceStyle?.decoration, TextDecoration.lineThrough);
      expect(originalPriceStyle?.color, Colors.grey);

      // Offer price style
      final offerPriceStyle = (textSpans[1] as TextSpan).style;
      expect(offerPriceStyle?.color, Colors.red);
      expect(offerPriceStyle?.decoration, isNull);

      // Unit style
      final unitStyle = (textSpans[2] as TextSpan).style;
      expect(unitStyle?.color, Colors.red);
      expect(unitStyle?.fontSize, 16.0);
    });

    testWidgets('handles different currency units', (tester) async {
      final usdProduct =
          createTestProduct(unit: const Unit(1)); // 1 represents USD

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductPrice(product: usdProduct),
          ),
        ),
      );

      expect(find.textContaining(StringConstant.usd, findRichText: true),
          findsOneWidget);
    });
  });
}
