import 'package:drift/drift.dart';

class Ebooks extends Table {
  TextColumn get encryptionKey => text().named('encryptionKey')();
  IntColumn get parentTermId =>
      integer().autoIncrement().named('parentTermId')();
  TextColumn get creation => text()();

  @override
  String? get tableName => 'ebooks';
}
