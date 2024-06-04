import 'dart:async';
import 'dart:io';

import 'package:beta/domain/answer.dart';
import 'package:beta/domain/answer_property.dart';
import 'package:beta/domain/coupon.dart';
import 'package:beta/domain/coupon_linked_to_term.dart';
import 'package:beta/domain/ebook.dart';
import 'package:beta/domain/fcm_topic.dart';
import 'package:beta/domain/flashcard.dart';
import 'package:beta/domain/http_request.dart';
import 'package:beta/domain/question.dart';
import 'package:beta/domain/question_linked_to_tag.dart';
import 'package:beta/domain/question_media.dart';
import 'package:beta/domain/question_property.dart';
import 'package:beta/domain/question_tag.dart';
import 'package:beta/domain/question_tag_property.dart';
import 'package:beta/domain/related_term.dart';
import 'package:beta/domain/term.dart';
import 'package:beta/domain/term_label.dart';
import 'package:beta/domain/term_last_access.dart';
import 'package:beta/domain/term_linked_to_label.dart';
import 'package:beta/domain/term_linked_to_tag.dart';
import 'package:beta/domain/term_parent.dart';
import 'package:beta/domain/term_property.dart';
import 'package:beta/domain/term_tag.dart';
import 'package:beta/domain/term_tree.dart';
import 'package:beta/domain/term_with_questions_filtering_enabled.dart';
import 'package:beta/domain/voice_note.dart';
import 'package:beta/infrastructure/device_repository.dart';
import 'package:beta/infrastructure/package_repository.dart';
import 'package:beta/main_controller.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:sqlcipher_flutter_libs/sqlcipher_flutter_libs.dart';
import 'package:sqlite3/open.dart';
import 'package:sqflite/sqflite.dart';

part 'database_service.g.dart'; // the generated code will be there

@DriftDatabase(tables: [
  Coupons,
  Terms,
  Answers,
  Questions,
  QuestionTags,
  QuestionMedias,
  FcmTopics,
  AnswerProperties,
  CouponsLinkedToTerms,
  TermTrees,
  Ebooks,
  TermsLastAccesses,
  QuestionTagProperties,
  QuestionProperties,
  HttpRequests,
  TermsWithQuestionsFilteringEnabled,
  Flashcards,
  VoiceNotes,
  RelatedTerms,
  QuestionsLinkedToTags,
  TermsParents,
  TermTags,
  TermsLinkedToTags,
  TermLabels,
  TermsLinkedToLabels,
  TermProperties
])
class DatabaseService extends _$DatabaseService {
  final PackageRepository packageRepository;
  final DeviceRepository deviceRepository;
  DatabaseService(
      {required this.deviceRepository, required this.packageRepository})
      : super(MainController.testing
            ? NativeDatabase.memory()
            : _openConnection(
                deviceRepository: deviceRepository,
                packageRepository: packageRepository));

  @override
  int get schemaVersion => 37;
}

LazyDatabase _openConnection(
    {required deviceRepository, required packageRepository}) {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
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
}
