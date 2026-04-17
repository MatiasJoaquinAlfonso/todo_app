import 'package:todo_app/features/todo/domain/repositories/event_repository.dart';

class RemoveCategoryFromTasksUseCase {
  final EventRepository repository;

  RemoveCategoryFromTasksUseCase(this.repository);

  Future<void> call(int oldCategoryId) {
    return repository.updateEventCategory(oldCategoryId, null);
  }
}
