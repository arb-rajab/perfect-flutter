// native.dart
import 'dart:io';

import 'package:beta/application/services/database_service.dart';
import 'package:beta/infrastructure/device/shared.dart';
import 'package:beta/infrastructure/package_repository.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:get/instance_manager.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:sqlcipher_flutter_libs/sqlcipher_flutter_libs.dart';
import 'package:sqlite3/open.dart';

DatabaseService constructDb() {
  var db = LazyDatabase(() async {
    DeviceRepository deviceRepository = Get.find();
    PackageRepository packageRepository = Get.find();
    String model = deviceRepository.getModel();

    String encryptionKey = model + packageRepository.getPackageName();

    // put the database file, called db.sqlite here, into the databases folder
    // for your app.
    final dbFolder = await getDatabasesPath();
    final file = File(p.join(dbFolder, 'QuizDatabase.db'));

    // Also work around limitations on old Android versions
    // if (Platform.isAndroid) {
    //   await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    // }

    // Make sqlite3 pick a more suitable location for temporary files - the
    // one from the system may be inaccessible due to sandboxing.
    // final cachebase = (await getTemporaryDirectory()).path;
    // We can't access /tmp on Android, which sqlite3 would try by default.
    // Explicitly tell it about the correct temporary directory.
    // sqlite3.tempDirectory = cachebase;

    Future<void> setupSqlCipher() async {
      // await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();

      await applyWorkaroundToOpenSqlCipherOnOldAndroidVersions();
      open.overrideFor(OperatingSystem.android, openCipherOnAndroid);
    }

    final token = RootIsolateToken.instance;
    return NativeDatabase.createInBackground(
      file,
      isolateSetup: () async {
        BackgroundIsolateBinaryMessenger.ensureInitialized(token!);
        await setupSqlCipher();
      },
      setup: (database) {
        // Check that we're actually running with SQLCipher by quering the
        // cipher_version pragma.
        final result = database.select('pragma cipher_version');
        if (result.isEmpty) {
          // throw UnsupportedError(
          //   'This database needs to run with SQLCipher, but that library is '
          //   'not available!',
          // );
          // isReady=true;
        } else {
          // Then, apply the key to encrypt the database. Unfortunately, this
          // pragma doesn't seem to support prepared statements so we inline the
          // key.
          final escapedKey = encryptionKey.replaceAll("'", "''");
          database.execute("pragma key = '$escapedKey'");

          // Test that the key is correct by selecting from a table
          database.execute('select count(*) from sqlite_master');
          // isReady=true;
        }
      },
    );
  });

  return DatabaseService(db);
}
