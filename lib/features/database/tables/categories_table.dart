import 'package:drift/drift.dart';

class CategoriesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 50)();
  IntColumn get color => integer()();
  IntColumn get priority => integer().withDefault(const Constant(0))();
}