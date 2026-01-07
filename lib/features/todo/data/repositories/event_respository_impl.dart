import 'package:todo_app/features/database/database.dart';
import 'package:todo_app/features/todo/domain/entities/event_entity.dart';
import 'package:todo_app/features/todo/domain/repositories/event_repository.dart';
import 'package:todo_app/features/todo/data/mappers/event_mapper.dart';
// import 'package:drift/drift.dart';


class EventsRespositoryImpl extends EventRepository {

  final AppDatabase db;

  EventsRespositoryImpl({required this.db});

  @override
  Stream<List<EventEntity>> getEvents() {
    return db.watchAllEvents().map((driftList){
      return driftList.map((item) => item.toEntity()).toList();
    });
  }

  @override
  Future<EventEntity?> getEventsById(int id) async {
    final query = db.select(db.events)..where((tbl) => tbl.id.equals(id));

    final result = await query.getSingleOrNull();

    return result?.toEntity();
  }

  @override
  Future<void> saveEvent(EventEntity event) async {
    await db.insertEvent(event.toCompanion());
  }

  @override
  Future<void> updateEvent(EventEntity event) async {
    await db.updateEvent(event.toCompanion());
  } 

  @override
  Future<void> deleteEvent(EventEntity event) async {
    await db.delete(db.events).delete(event.toCompanion());
  }

}

