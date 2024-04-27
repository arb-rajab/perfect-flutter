import 'package:drift/drift.dart';

class VoiceNotes extends Table {
  //ignore string url
  BlobColumn get encryptionKey => blob().named('encryptionKey')();
  IntColumn get parentTermId => integer().named('parentTermId')();
  DateTimeColumn get creation => dateTime()();
  DateTimeColumn get lastUpdated => dateTime().named('lastUpdated')();

  @override
  Set<Column<Object>>? get primaryKey => {parentTermId};

  @override
  String? get tableName => 'voiceNotes';
}
