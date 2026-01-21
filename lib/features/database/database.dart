import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'tables/tables.dart';
part 'database.g.dart';




@DriftDatabase(tables: [Events, NotificationTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(

    // Habilito las foreing Keys en SQL Lite y el Cascade Delete. 
    // Esto evita que no queden registros de notificaciones relacionadas a tareas borradas.
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreing_key = ON');
    },

    // Si es una instalacion nueva crea todo de 0.
    onCreate: (m) async {
      await m.createAll();
    },

    onUpgrade: (m, from, to) async {
      // Si actualizamos la app, las tareas ya creadas por el usuario no se borran.
      // Solo se crea en este caso esta tabla nueva.
      if (from < 2) {
        await m.createTable(notificationTable);
      }
    },

  );


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