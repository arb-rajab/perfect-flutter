import 'package:drift/drift.dart';

class VoiceNotes extends Table {
  TextColumn get encryptionKey => text().named('encryptionKey')();
  IntColumn get parentTermId => integer().named('parentTermId')();
  TextColumn get creation => text()();

  @override
  Set<Column<Object>>? get primaryKey => {parentTermId};

  @override
  String? get tableName => 'voiceNotes';
}
