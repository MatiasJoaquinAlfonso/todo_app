import 'package:todo_app/features/todo/domain/entities/category_entity.dart';
import 'package:todo_app/features/todo/domain/repositories/category_repository.dart';

class UpdateCategoryUseCase {
  final CategoryRepository repository;

  UpdateCategoryUseCase(this.repository);

  Future<void> call(CategoryEntity category) {
    return repository.updateCategory(category);
  }
}
