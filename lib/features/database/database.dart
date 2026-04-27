import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'tables/tables.dart';
part 'database.g.dart';




@DriftDatabase(tables: [Events, NotificationTable, CategoriesTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(

    // Habilito las foreing Keys en SQL Lite y el Cascade Delete. 
    // Esto evita que no queden registros de notificaciones relacionadas a tareas borradas.
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_key = ON');
    },

    // Si es una instalacion nueva crea todo de 0.
    onCreate: (m) async {
      await m.createAll();

      await batch((batch) {
          batch.insertAll(categoriesTable, [
            CategoriesTableCompanion.insert(
              title: 'Trabajo',
              color: 0xFFF44336,
              priority: Value(0),
            ),
            CategoriesTableCompanion.insert(
              title: 'Estudio',
              color: 0xFF2196F3,
              priority: Value(0),
            ),
            CategoriesTableCompanion.insert(
              title: 'Hobby',
              color: 0xFF4CAF50,
              priority: Value(0),
            )
          ]);
        },
      );

      

    },

    onUpgrade: (m, from, to) async {
      // Si actualizamos la app, las tareas ya creadas por el usuario no se borran.
      // Solo se crea en este caso esta tabla nueva.
      if (from < 2) {
        await m.createTable(notificationTable);
      }

      if (from < 3) {


        
        await m.createTable(categoriesTable);

        await m.addColumn(events, events.fkCategoryID);

        await batch((batch) {
            batch.insertAll(categoriesTable, [
              CategoriesTableCompanion.insert(
                title: 'Trabajo',
                color: 0xFFF44336,
                priority: Value(1),
              ),
              CategoriesTableCompanion.insert(
                title: 'Estudio',
                color: 0xFF2196F3,
                priority: Value(2),
              ),
              CategoriesTableCompanion.insert(
                title: 'Hobby',
                color: 0xFF4CAF50,
                priority: Value(3),
              )
            ]);
          },
        );

      }
      
      if (from < 4) {
        // Añadimos retroactivamente el nuevo campo `priority` a las notas ya existentes
        await m.addColumn(events, events.priority);
      }

      if (from < 5) {
        // Campos para la sincronización con Google Calendar
        await m.addColumn(events, events.googleEventId);
        await m.addColumn(events, events.isSynced);
        await m.addColumn(events, events.lastSyncedAt);
        await m.addColumn(events, events.syncStatus);
      }
    },

  );

  // Eventos/tareas
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

  Future<int> deleteEventByCategoryId(int categoryId) {
    return (delete(events)..where((tbl) => tbl.fkCategoryID.equals(categoryId))).go();
  }

  Future<void> updateEventByCategoryId(int oldCategoryId, int? newCategoryId) {
    return (update(events)..where((tbl) => tbl.fkCategoryID.equals(oldCategoryId)))
      .write(EventsCompanion(fkCategoryID: Value(newCategoryId)));
  }

  // Categorias 
  Future<List<CategoriesTableData>> getAllCategories(){
    return select(categoriesTable).get();
  }

  Stream<List<CategoriesTableData>> watchAllCategories() {
    return select(categoriesTable).watch();
  }

  Future<int> insertCategory(CategoriesTableCompanion category) {
    return into(categoriesTable).insert(category);
  }

  Future<int> deleteCategory(CategoriesTableCompanion category){
    return delete(categoriesTable).delete(category);
  }

  Future<bool> updateCategory(CategoriesTableCompanion category) {
    return update(categoriesTable).replace(category);
  }

  Future<List<Event>> getEventsByCategoryId(int categoryId) {
    return (select(events)..where((tbl) => tbl.fkCategoryID.equals(categoryId))).get();
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