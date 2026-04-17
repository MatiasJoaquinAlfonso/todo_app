import 'package:todo_app/features/todo/domain/entities/event_entity.dart';
import 'package:todo_app/features/todo/domain/entities/notification_entity.dart';

abstract class EventRepository {

  Future<EventEntity?> getEventsById(int id);

  Stream<List<EventEntity>> getEvents({bool isDone = false});

  Future<int> saveEvent(EventEntity event);

  Future<void> deleteEvent(EventEntity event);

  Future<void> updateEvent(EventEntity event);

  Future<int> addNotification(NotificationEntity notification);

  Future<List<NotificationEntity>> getNotifications(int taskId);

  Future<void> deleteNotifications(int taskId);

  Future<int> countTaskByCategoryId(int categoryId);

  Future<void> updateEventCategory(int oldCategoryId, int? newCategoryId);

  Future<int> deleteEventByCategoryId(int categoryId);
}