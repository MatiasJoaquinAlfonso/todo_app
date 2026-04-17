import 'package:todo_app/features/todo/domain/entities/event_entity.dart';
import 'package:todo_app/features/todo/domain/repositories/event_repository.dart';

class CreateEventUseCase {
  final EventRepository repository;

  CreateEventUseCase(this.repository);

  Future<int> call(EventEntity event) {
    return repository.saveEvent(event);
  }
}
