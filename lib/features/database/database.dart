import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
part 'database.g.dart';

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

// Abrimos la base de datos en el hilo principal para evitar errores de comunicacion entre hilos
// Se realizo este cambio porque la app se pausaba sola constantemente.
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'todo-app-db.sqlite'));
    return NativeDatabase(file); 
  });
}