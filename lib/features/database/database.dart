import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';


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

@DriftDatabase(tables: [Events])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Event>> getAllEvents(){
    return select(events).get();
  }

  Stream<List<Event>> watchAllEvents() {
    return select(events).watch();
  }

  Future<int> insertEvent(EventsCompanion event) {
    return into(events).insert(event);
  }

  Future<int> deleteEvent(Event event){
    return delete(events).delete(event);
  }

  Future<bool> updateEvent(EventsCompanion event) {
    return update(events).replace(event);
  }

}

QueryExecutor _openConnection() {
  return driftDatabase(name: 'todo-app-db');
}