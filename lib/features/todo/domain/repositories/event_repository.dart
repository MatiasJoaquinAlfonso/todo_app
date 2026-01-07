import 'package:todo_app/features/todo/domain/entities/event_entity.dart';

abstract class EventRepository {

  Future<EventEntity?> getEventsById(int id);

  Stream<List<EventEntity>> getEvents();

  Future<void> saveEvent(EventEntity event);

  Future<void> deleteEvent(EventEntity event);

  Future<void> updateEvent(EventEntity event);

}