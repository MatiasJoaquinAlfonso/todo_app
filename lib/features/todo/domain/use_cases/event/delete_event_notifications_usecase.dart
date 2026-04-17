import 'package:todo_app/features/todo/domain/repositories/event_repository.dart';

class DeleteEventNotificationsUseCase {
  final EventRepository repository;

  DeleteEventNotificationsUseCase(this.repository);

  Future<void> call(int taskId) {
    return repository.deleteNotifications(taskId);
  }
}
