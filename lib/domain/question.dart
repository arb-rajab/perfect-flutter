import 'package:drift/drift.dart';

@DataClassName('questions')
@TableIndex(name: 'qIndex1', columns: {#parentTermId})
class Questions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => text()();
  TextColumn get title => text()();
  TextColumn get titleTranslation =>
      text().withDefault(const Constant('')).named('titleTranslation')();
  IntColumn get labelId => integer().named('labelId')();
  TextColumn get note => text()();
  TextColumn get noteTranslation =>
      text().withDefault(const Constant('')).named('noteTranslation')();
  IntColumn get parentTermId => integer().named('parentTermId')();
  IntColumn get specialCharacter => integer().named('specialCharacter')();
  IntColumn get type => integer()();
  IntColumn get edited => integer().withDefault(const Constant(0))();
  TextColumn get imageUrl =>
      text().withDefault(const Constant('')).named('imageUrl')();
  //ignore
  // BoolColumn get imageVisible => boolean().withDefault(Constant(false))();
  DateTimeColumn get creation => dateTime()();
  DateTimeColumn get editionDate => dateTime().named('editionDate')();

  //ignore
  // BoolColumn get corrected => boolean().withDefault(Constant(false))();
  // BoolColumn get translated => boolean().withDefault(Constant(false))();
}
