import 'package:todo_app/features/todo/domain/repositories/event_repository.dart';

class DeleteTasksByCategoryUseCase {
  final EventRepository repository;

  DeleteTasksByCategoryUseCase(this.repository);

  Future<int> call(int categoryId) {
    return repository.deleteEventByCategoryId(categoryId);
  }
}
