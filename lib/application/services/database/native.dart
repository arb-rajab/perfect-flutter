import 'dart:io';

import 'package:beta/abstract/device_repository_base.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/infrastructure/package_repository.dart';
import 'package:beta/main_controller.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:get/instance_manager.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common/sqflite.dart';
import 'package:share_plus/share_plus.dart';

DatabaseService constructDb() {
  if (MainController.testing) return DatabaseService(NativeDatabase.memory());

  var db = LazyDatabase(() async {
    DeviceRepositoryBase deviceRepository = Get.find();
    PackageRepository packageRepository = Get.find();
    String model = deviceRepository.getModel();
    String encryptionKey = '$model${packageRepository.getPackageName()}';

    final dbFolder = await getDatabasesPath();
    final file = File(p.join(dbFolder, 'QuizDatabase.db'));

    return NativeDatabase.createInBackground(
      file,
      setup: (database) {
        database.execute("pragma cipher = 'sqlcipher'");
        database.execute('pragma legacy = 4');

        final escapedKey = encryptionKey.replaceAll("'", "''");
        database.execute("pragma key = '$escapedKey'");
        database.execute('select count(*) from sqlite_master');
      },
    );
  });

  return DatabaseService(db);
}

Future<void> exportDatabaseFile() async {
  final dbFolder = await getDatabasesPath();
  final sourceFile = File(p.join(dbFolder, 'QuizDatabase.db'));

  if (!await sourceFile.exists()) {
    throw Exception('Database file not found at ${sourceFile.path}');
  }

  // Copy to temp first — avoids reading the live database file directly
  final tempDir = await getTemporaryDirectory();
  final exportFile = File(
    p.join(
      tempDir.path,
      'QuizDatabase_${DateTime.now().millisecondsSinceEpoch}.db',
    ),
  );
  await sourceFile.copy(exportFile.path);

  await Share.shareXFiles([
    XFile(exportFile.path, mimeType: 'application/octet-stream'),
  ], subject: 'QuizDatabase export');
}
