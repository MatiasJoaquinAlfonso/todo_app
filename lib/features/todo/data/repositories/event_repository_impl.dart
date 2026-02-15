import 'package:todo_app/features/database/database.dart';
import 'package:todo_app/features/todo/domain/entities/event_entity.dart';
import 'package:todo_app/features/todo/domain/repositories/event_repository.dart';
import 'package:todo_app/features/todo/data/mappers/event_mapper.dart';

class EventRepositoryImpl extends EventRepository {

  final AppDatabase db;

  EventRepositoryImpl({required this.db});

  @override
  Stream<List<EventEntity>> getEvents({bool isDone = false}) {

    final query = db.select(db.events)..where((tbl) => tbl.isDone.equals(isDone));
    return query.watch().map((driftList) {
      return driftList.map((e) => e.toEntity()).toList();
    },);

    // return db.watchAllEvents().map((driftList){
    //   return driftList.map((item) => item.toEntity()).toList();
    // });

  }

  @override
  Future<EventEntity?> getEventsById(int id) async {
    final query = db.select(db.events)..where((tbl) => tbl.id.equals(id));

    final result = await query.getSingleOrNull();

    return result?.toEntity();
  }

  @override
  Future<int> saveEvent(EventEntity event) async {
    return await db.insertEvent(event.toCompanion());
  }

  @override
  Future<void> updateEvent(EventEntity event) async {
    await db.updateEvent(event.toCompanion());
  } 

  @override
  Future<void> deleteEvent(EventEntity event) async {
    await db.delete(db.events).delete(event.toCompanion());
  }
  
  @override
  Future<int> addNotification(NotificationTableCompanion notification) async {
    return await db.into(db.notificationTable).insert(notification);
  }
  
  @override
  Future<List<NotificationTableData>> getNotifications(int taskId) async {
    final query = db.select(db.notificationTable)..where((tbl) => tbl.eventId.equals(taskId));
    final result = await query.get();
    return result;
  }
  
  @override
  Future<void> deleteNotifications(int taskId) async {
    await (db.delete(db.notificationTable)..where((tbl) => tbl.eventId.equals(taskId))).go();
  }

  @override
  Future<int> countTaskByCategoryId(int categoryId) async {
    final tasks = await db.getEventsByCategoryId(categoryId);
    return tasks.length;
  }
  
  @override
  Future<void> updateEventCategory(int oldCategoryId, int? newCategoryId) async {
    await db.updateEventByCategoryId(oldCategoryId, newCategoryId);
  }

  @override
  Future<int> deleteEventByCategoryId(int categoryId) async {
    return await db.deleteEventByCategoryId(categoryId);
  } 

}

