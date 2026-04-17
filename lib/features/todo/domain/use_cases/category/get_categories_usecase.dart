import 'package:todo_app/features/todo/domain/entities/category_entity.dart';
import 'package:todo_app/features/todo/domain/repositories/category_repository.dart';

class GetCategoriesUseCase {
  final CategoryRepository repository;

  GetCategoriesUseCase(this.repository);

  Stream<List<CategoryEntity>> call() {
    return repository.getCategories();
  }
}
