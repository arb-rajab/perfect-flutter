import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/image_service.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/value/deleted_at.dart';
import 'package:beta/domain/value/visible.dart';
import 'package:beta/main.dart';
import 'package:beta/constants/arguments.dart';
import 'package:beta/presentation/images/images_screen.dart';
import 'package:beta/presentation/media_slider/media_slider_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

import '../../common/tests.dart';

Future<void> main() async {
  setUp(() async {
    await initTests();
  });

  tearDown(() async {
    await databaseService.deleteAllTables();
    Get.deleteAll(force: true);
  });

  group('ImagesScreen', () {
    testWidgets('network image is loaded, title and info are hidden initially', (
      tester,
    ) async {
      await databaseService.seedTermsData();
      ImageService imageService = Get.find();
      await imageService.addImages([
        const Image(
          id: 1000,
          url: 'https://example.com/image.png',
          title: 'My Image Title',
          info: 'My image info',
          parentTermId: 3,
        ),
      ]);

      Get.delete<ImagesScreenArgument>();
      Get.put(
        ImagesScreenArgument(
          query: 'select * from images where parentTermId=3',
          title: 'grand child',
          term: TermData(
            const Term(
              name: 'grand child',
              enabled: 1,
              id: 3,
              uuid: 'a',
              type: TermType.images,
              creation: '2022-01-01 11:11:11',
              free: 1,
              ordering: 1,
              needsUpdate: 0,
              captureable: 1,
              textCulumn: '',
              outerNote: '',
            ),
            deletedAt: const DeletedAt(null),
            visible: const Visible(1),
          ),
        ),
      );

      await tester.pumpWidget(const MyApp(defaultRoute: ImagesScreen.route));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      // Image should be visible (CachedNetworkImage or error icon)
      expect(find.byType(CachedNetworkImage), findsOneWidget);
      // OR if error widget is shown due to invalid URL:
      // expect(find.byIcon(Icons.error), findsOneWidget);

      // Title and info should NOT be visible initially (hidden by ExpansionTile)
      expect(find.text('My Image Title'), findsNothing);
      expect(find.text('My image info'), findsNothing);

      // ExpansionTile arrow should be visible
      expect(find.byType(ExpansionTile), findsOneWidget);
    });

    testWidgets('tapping the arrow shows title and info, and keeps image', (
      tester,
    ) async {
      await databaseService.seedTermsData();
      ImageService imageService = Get.find();
      await imageService.addImages([
          const Image(
          id: 1000,
          url: 'https://example.com/image.png',
          title: 'My Image Title',
          info: 'My image info',
          parentTermId: 3,
          ),
      ]);

      Get.delete<ImagesScreenArgument>();
      Get.put(
        ImagesScreenArgument(
          query: 'select * from images where parentTermId=3',
          title: 'grand child',
          term: TermData(
            const Term(
              name: 'grand child',
              enabled: 1,
              id: 3,
              uuid: 'a',
              type: TermType.images,
              creation: '2022-01-01 11:11:11',
              free: 1,
              ordering: 1,
              needsUpdate: 0,
              captureable: 1,
              textCulumn: '',
              outerNote: '',
            ),
            deletedAt: const DeletedAt(null),
            visible: const Visible(1),
          ),
        ),
      );

      await tester.pumpWidget(const MyApp(defaultRoute: ImagesScreen.route));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      // Tap on the ExpansionTile arrow to expand
      await tester.tap(find.byType(ExpansionTile));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      // Title and info should now be visible
      expect(find.text('My Image Title'), findsOneWidget);
      expect(find.text('My image info'), findsOneWidget);

      // Image should still be visible
      expect(find.byType(CachedNetworkImage), findsOneWidget);
      // OR: expect(find.byIcon(Icons.error), findsOneWidget);
    });

    testWidgets('retapping the arrow hides title and info, and keeps image', (
      tester,
    ) async {
      await databaseService.seedTermsData();
      ImageService imageService = Get.find();
      await imageService.addImages([
        const Image(
          id: 1000,
          url: 'https://example.com/image.png',
          title: 'My Image Title',
          info: 'My image info',
          parentTermId: 3,
        ),
      ]);

      Get.delete<ImagesScreenArgument>();
      Get.put(
        ImagesScreenArgument(
          query: 'select * from images where parentTermId=3',
          title: 'grand child',
          term: TermData(
            const Term(
              name: 'grand child',
              enabled: 1,
              id: 3,
              uuid: 'a',
              type: TermType.images,
              creation: '2022-01-01 11:11:11',
              free: 1,
              ordering: 1,
              needsUpdate: 0,
              captureable: 1,
              textCulumn: '',
              outerNote: '',
            ),
            deletedAt: const DeletedAt(null),
            visible: const Visible(1),
          ),
        ),
      );

      await tester.pumpWidget(const MyApp(defaultRoute: ImagesScreen.route));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      // First tap to expand
      await tester.tap(find.byType(ExpansionTile));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      // Verify expanded state
      expect(find.text('My Image Title'), findsOneWidget);
      expect(find.text('My image info'), findsOneWidget);
      expect(find.byType(CachedNetworkImage), findsOneWidget);

      // Second tap to collapse
      await tester.tap(find.byType(ExpansionTile));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      // Title and info should be hidden again
      expect(find.text('My Image Title'), findsNothing);
      expect(find.text('My image info'), findsNothing);

      // Image should still be visible
      expect(find.byType(CachedNetworkImage), findsOneWidget);
      // OR: expect(find.byIcon(Icons.error), findsOneWidget);
    });

    testWidgets('tapping the image opens media slider screen', (tester) async {
      await databaseService.seedTermsData();
      ImageService imageService = Get.find();
      await imageService.addImages([
        const Image(
          id: 1000,
          url: 'https://example.com/image.png',
          title: 'My Image Title',
          info: 'My image info',
          parentTermId: 3,
        ),
      ]);

      Get.delete<ImagesScreenArgument>();
      Get.put(
        ImagesScreenArgument(
          query: 'select * from images where parentTermId=3',
          title: 'grand child',
          term: TermData(
            const Term(
              name: 'grand child',
              enabled: 1,
              id: 3,
              uuid: 'a',
              type: TermType.images,
              creation: '2022-01-01 11:11:11',
              free: 1,
              ordering: 1,
              needsUpdate: 0,
              captureable: 1,
              textCulumn: '',
              outerNote: '',
            ),
            deletedAt: const DeletedAt(null),
            visible: const Visible(1),
          ),
        ),
      );

      await tester.pumpWidget(const MyApp(defaultRoute: ImagesScreen.route));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      // Tap on the image (GestureDetector wrapping CachedNetworkImage)
      await tester.tap(find.byType(CachedNetworkImage));
      await tester.pumpAndSettle();

      // MediaSliderScreen should be opened
      expect(find.byType(MediaSliderScreen), findsOneWidget);
    });

    testWidgets(
      'number of cards equals number of images related to the parent term',
      (tester) async {
        await databaseService.seedTermsData();
        ImageService imageService = Get.find();

        await imageService.addImages([
          const Image(
            id: 1000,
            url: 'https://example.com/image1.png',
            title: 'My Image Title 1',
            info: 'My image info 1',
            parentTermId: 3,
          ),
          const Image(
            id: 1001,
            url: 'https://example.com/image2.png',
            title: 'My Image Title 2',
            info: 'My image info 2',
            parentTermId: 3,
          ),
          // image related to another term, should not be loaded
          const Image(
            id: 1002,
            url: 'https://example.com/image3.png',
            title: 'My Image Title 3',
            info: 'My image info 3',
            parentTermId: 10,
          ),
        ]);

        Get.delete<ImagesScreenArgument>();
        Get.put(
          ImagesScreenArgument(
            query: 'select * from images where parentTermId=3',
            title: 'grand child',
            term: TermData(
              const Term(
                name: 'grand child',
                enabled: 1,
                id: 3,
                uuid: 'a',
                type: TermType.images,
                creation: '2022-01-01 11:11:11',
                free: 1,
                ordering: 1,
                needsUpdate: 0,
                captureable: 1,
                textCulumn: '',
                outerNote: '',
              ),
              deletedAt: const DeletedAt(null),
              visible: const Visible(1),
            ),
          ),
        );

        await tester.pumpWidget(const MyApp(defaultRoute: ImagesScreen.route));
        await tester.pump();
        await tester.pump(const Duration(seconds: 1));

        expect(find.byType(Card), findsNWidgets(2));
      },
    );
  });
}
