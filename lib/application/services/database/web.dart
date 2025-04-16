import 'package:beta/abstract/device_repository_base.dart';
import 'package:beta/application/services/database_service.dart';
import 'package:beta/infrastructure/package_repository.dart';
import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:get/instance_manager.dart';

DatabaseService constructDb() {
  return DatabaseService(connectOnWeb());
}

DatabaseConnection connectOnWeb() {
  return DatabaseConnection.delayed(Future(() async {
    final result = await WasmDatabase.open(
      databaseName:
          'quiz_database.db', // prefer to only use valid identifiers here
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.js'),
      localSetup: (database) {
        DeviceRepositoryBase deviceRepository = Get.find();
        PackageRepository packageRepository = Get.find();
        String model = deviceRepository.getModel();

        String encryptionKey = model + packageRepository.getPackageName();
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

    if (result.missingFeatures.isNotEmpty) {
      // Depending how central local persistence is to your app, you may want
      // to show a warning to the user if only unrealiable implemetentations
      // are available.
      print('Using ${result.chosenImplementation} due to missing browser '
          'features: ${result.missingFeatures}');
    }

    return result.resolvedExecutor;
  }));
}
