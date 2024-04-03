import 'package:drift/drift.dart';

@DataClassName('ebooks')
class Ebooks extends Table {
  //url string ignored
  TextColumn get encryptionKey => text().named('encryptionKey')();
  IntColumn get parentTermId =>
      integer().autoIncrement().named('parentTermId')();
  DateTimeColumn get creation => dateTime()();
  DateTimeColumn get lastUpdated => dateTime().named('lastUpdated')();
}
