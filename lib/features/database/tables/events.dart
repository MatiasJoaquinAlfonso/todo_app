import 'package:drift/drift.dart';
import 'package:todo_app/features/database/tables/tables.dart';

class Events extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 100)();
  TextColumn get subTitle => text().withLength(min: 1, max: 150).nullable()();
  TextColumn get description => text().nullable()();

  // Fechas
  DateTimeColumn get dateInit => dateTime()();
  DateTimeColumn get dateFinish => dateTime()();
  
  // Flags
  BoolColumn get isAllDay => boolean().withDefault(const Constant(false))();
  BoolColumn get isDone => boolean().withDefault(const Constant(false))();
  IntColumn get color => integer().nullable()();

  IntColumn get fkCategoryID => integer().nullable().references(CategoriesTable, #id)();
}