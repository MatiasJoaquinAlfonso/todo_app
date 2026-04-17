import 'package:todo_app/features/todo/domain/entities/category_entity.dart';
import 'package:todo_app/features/todo/domain/repositories/category_repository.dart';

class CreateCategoryUseCase {
  final CategoryRepository repository;

  CreateCategoryUseCase(this.repository);

  Future<void> call(CategoryEntity category) {
    return repository.createCategory(category);
  }
}
