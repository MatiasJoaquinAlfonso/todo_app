import 'package:todo_app/features/todo/domain/entities/category_entity.dart';
import 'package:todo_app/features/todo/domain/repositories/category_repository.dart';

class DeleteCategoryUseCase {
  final CategoryRepository repository;

  DeleteCategoryUseCase(this.repository);

  Future<void> call(CategoryEntity category) {
    return repository.deleteCategory(category);
  }
}
