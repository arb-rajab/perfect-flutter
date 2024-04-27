import 'package:drift/drift.dart';

class Ebooks extends Table {
  //url string ignored
  TextColumn get encryptionKey => text().named('encryptionKey')();
  IntColumn get parentTermId =>
      integer().autoIncrement().named('parentTermId')();
  DateTimeColumn get creation => dateTime()();
  DateTimeColumn get lastUpdated => dateTime().named('lastUpdated')();

  @override
  String? get tableName => 'ebooks';
}
