import 'package:beta/application/services/database_service.dart';

class ImageService {
  final DatabaseService databaseService;

  ImageService({required this.databaseService});

  Future addImages(List<Image> images) => databaseService.batch((batch) =>
      batch.insertAllOnConflictUpdate(databaseService.images, images));

  Future<List<Image>> getImagesFromQuery(String query) => (databaseService
      .customSelect(query)
      .watch()
      .map((rows) => rows
          .map(
            (row) => databaseService.images.map(row.data),
          )
          .toList())
      .first);
}
