import 'package:drift/drift.dart';
import 'package:todo_app/features/database/tables/tables.dart';




class NotificationTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get eventId => integer().references(
    Events, 
    #id,
    onDelete: KeyAction.cascade
  )();
  DateTimeColumn get scheduleDate => dateTime()();

}