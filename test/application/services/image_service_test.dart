import 'package:beta/application/services/image_service.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:get/instance_manager.dart';
import 'package:test/test.dart';

import '../../common/tests.dart';

void main() async {
  late ImageService imageService = Get.find();
  setUp(() async {
    await initTests();
    imageService = Get.find();
  });

  group('ImageService', () {
    test('addImages adds images', () async {
      const image = Image(
        id: 1,
        url: 'url1',
        title: 'head1',
        info: 'tail1',
        parentTermId: 10,
      );

      // Ensure no images exist
      final before = await (databaseService.select(
        databaseService.images,
      )..where((tbl) => tbl.id.equals(image.id))).get();
      expect(before.length, 0);

      await imageService.addImages([image]);

      final after = await (databaseService.select(
        databaseService.images,
      )..where((tbl) => tbl.id.equals(image.id))).get();
      expect(after.length, 1);
      expect(after.first.url, 'url1');
      expect(after.first.title, 'head1');
      expect(after.first.info, 'tail1');
      expect(after.first.parentTermId, 10);
    });

    test('addImages adds images overrides current image', () async {
      const image = Image(
        id: 1,
        url: 'url1',
        title: 'head1',
        info: 'tail1',
        parentTermId: 10,
      );

      // Ensure no images exist
      final before = await (databaseService.select(
        databaseService.images,
      )..where((tbl) => tbl.id.equals(image.id))).get();
      expect(before.length, 0);

      await imageService.addImages([image]);

      var after = await (databaseService.select(
        databaseService.images,
      )..where((tbl) => tbl.id.equals(image.id))).get();
      expect(after.length, 1);

      await imageService.addImages([image.copyWith(title: 'head2')]);
      after = await (databaseService.select(
        databaseService.images,
      )..where((tbl) => tbl.id.equals(image.id))).get();

      expect(after.length, 1);
      expect(after.first.url, 'url1');
      expect(after.first.title, 'head2');
      expect(after.first.info, 'tail1');
      expect(after.first.parentTermId, 10);
    });

    test('getImagesFromQuery returns correct images', () async {
      const image = Image(
        id: 2,
        url: 'url2',
        title: 'head2',
        info: 'tail2',
        parentTermId: 20,
      );

      const image2 = Image(
        id: 3,
        url: 'url3',
        title: 'head3',
        info: 'tail3',
        parentTermId: 30,
      );
      await imageService.addImages([image, image2]);

      final result = await imageService.getImagesFromQuery(
        'SELECT * FROM images WHERE id = 2',
      );
      expect(result.length, 1);
      expect(result.first.id, 2);
      expect(result.first.url, 'url2');
      expect(result.first.title, 'head2');
      expect(result.first.info, 'tail2');
      expect(result.first.parentTermId, 20);
    });
  });
}
