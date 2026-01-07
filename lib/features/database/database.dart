import 'package:drift/drift.dart';

class Events extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 100)();
  TextColumn get subTitle => text().withLength(min: 1, max: 150).nullable()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get dateInit => dateTime()();
  DateTimeColumn get dateFinish => dateTime().nullable()();
  BoolColumn get isAllDay => boolean().withDefault(const Constant(false))();
  IntColumn get color => integer().nullable()();

}