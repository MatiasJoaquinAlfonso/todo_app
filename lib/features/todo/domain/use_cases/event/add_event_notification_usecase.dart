import 'package:todo_app/features/todo/domain/entities/notification_entity.dart';
import 'package:todo_app/features/todo/domain/repositories/event_repository.dart';

class AddEventNotificationUseCase {
  final EventRepository repository;

  AddEventNotificationUseCase(this.repository);

  Future<int> call(NotificationEntity notification) {
    return repository.addNotification(notification);
  }
}
