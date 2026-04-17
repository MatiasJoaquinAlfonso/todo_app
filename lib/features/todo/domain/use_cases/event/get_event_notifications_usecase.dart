import 'package:todo_app/features/todo/domain/entities/notification_entity.dart';
import 'package:todo_app/features/todo/domain/repositories/event_repository.dart';

class GetEventNotificationsUseCase {
  final EventRepository repository;

  GetEventNotificationsUseCase(this.repository);

  Future<List<NotificationEntity>> call(int taskId) {
    return repository.getNotifications(taskId);
  }
}
