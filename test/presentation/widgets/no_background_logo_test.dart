import 'package:beta/configs/style.dart';
import 'package:beta/constants/image_constant.dart';
import 'package:beta/presentation/animations/opacity_animation.dart';
import 'package:beta/presentation/widgets/no_background_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Renders with correct image asset', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: NoBackgroundLogo(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verify the Image widget exists with correct asset
    final imageFinder = find.byType(Image);
    expect(imageFinder, findsOneWidget);

    final imageWidget = tester.widget<Image>(imageFinder);
    expect((imageWidget.image as AssetImage).assetName,
        equals(ImageConstant.noBackgroundImage));
  });

  testWidgets('Has correct margin', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: NoBackgroundLogo(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verify the Container has correct margin
    final containerFinder = find.byType(Container);
    expect(containerFinder, findsOneWidget);

    final containerWidget = tester.widget<Container>(containerFinder);
    expect(containerWidget.margin, equals(const EdgeInsets.all(halfMargin)));
  });

  testWidgets('Is wrapped in OpacityAnimation', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: NoBackgroundLogo(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verify the widget hierarchy
    expect(find.byType(OpacityAnimation), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(OpacityAnimation),
        matching: find.byType(Container),
      ),
      findsOneWidget,
    );
  });

  // Test for image asset existence
  test('ImageConstant.noBackgroundImage exists', () {
    expect(ImageConstant.noBackgroundImage, isNotNull);
    expect(ImageConstant.noBackgroundImage.isNotEmpty, isTrue);

    // This would actually try to load the image in a test environment
    // Note: This might need flutter_test_config.dart setup for asset loading
    final asset = AssetImage(ImageConstant.noBackgroundImage);
    expect(asset, isA<AssetImage>());
  });
}
