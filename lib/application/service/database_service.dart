import 'dart:async';
import 'dart:io';

import 'package:beta/infrastructure/device_repository.dart';
import 'package:beta/infrastructure/package_repository.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlcipher_flutter_libs/sqlcipher_flutter_libs.dart';
import 'package:sqlite3/open.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqflite/sqflite.dart';

part 'database_service.g.dart'; // the generated code will be there

final databaseServiceProvider = Provider((ref) => DatabaseService(
    ref.read(deviceRepository), ref.read(packageRepositoryProvider)));

@DriftDatabase(tables: [])
class DatabaseService extends _$DatabaseService {
  DatabaseService(
      DeviceRepository deviceRepository, PackageRepository packageRepository)
      : super(_openConnection(deviceRepository, packageRepository));

  @override
  int get schemaVersion => 37;

  bool isOpened = false;

  @override
  Future<T> doWhenOpened<T>(FutureOr<T> Function(QueryExecutor e) fn) {
    isOpened   = true;
    return super.doWhenOpened(fn);
  }
}

LazyDatabase _openConnection(
    DeviceRepository deviceRepository, PackageRepository packageRepository) {
  // the LazyDatabase util lets us find the right location for the file async.

  return LazyDatabase(() async {
    String model = deviceRepository.getModel();

    String encryptionKey = model + packageRepository.getPackageName();

    // put the database file, called db.sqlite here, into the databases folder
    // for your app.
    final dbFolder = await getDatabasesPath();
    final file = File(p.join(dbFolder, 'QuizDatabase.db'));

    // Also work around limitations on old Android versions
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    // Make sqlite3 pick a more suitable location for temporary files - the
    // one from the system may be inaccessible due to sandboxing.
    final cachebase = (await getTemporaryDirectory()).path;
    // We can't access /tmp on Android, which sqlite3 would try by default.
    // Explicitly tell it about the correct temporary directory.
    sqlite3.tempDirectory = cachebase;

    Future<void> setupSqlCipher() async {
      await applyWorkaroundToOpenSqlCipherOnOldAndroidVersions();
      open.overrideFor(OperatingSystem.android, openCipherOnAndroid);
    }

    return NativeDatabase.createInBackground(
      file,
      isolateSetup: () async {
        final token = RootIsolateToken.instance;
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
}
