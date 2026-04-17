import 'package:todo_app/features/todo/domain/repositories/event_repository.dart';

class CountTasksByCategoryUseCase {
  final EventRepository repository;

  CountTasksByCategoryUseCase(this.repository);

  Future<int> call(int categoryId) {
    return repository.countTaskByCategoryId(categoryId);
  }
}
