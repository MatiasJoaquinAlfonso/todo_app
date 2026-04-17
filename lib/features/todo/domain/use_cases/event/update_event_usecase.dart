import 'package:todo_app/features/todo/domain/entities/event_entity.dart';
import 'package:todo_app/features/todo/domain/repositories/event_repository.dart';

class UpdateEventUseCase {
  final EventRepository repository;

  UpdateEventUseCase(this.repository);

  Future<void> call(EventEntity event) {
    return repository.updateEvent(event);
  }
}
