import 'package:todo_app/features/todo/domain/entities/event_entity.dart';
import 'package:todo_app/features/todo/domain/repositories/event_repository.dart';

class GetEventsUseCase {
  final EventRepository repository;

  GetEventsUseCase(this.repository);

  Stream<List<EventEntity>> call({bool isDone = false}) {
    return repository.getEvents(isDone: isDone);
  }
}
