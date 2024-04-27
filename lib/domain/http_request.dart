import 'package:drift/drift.dart';

class HttpRequests extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get url => text()();
  TextColumn get mapp => text().named('map')();

  @override
  String? get tableName => 'httpRequests';
}
