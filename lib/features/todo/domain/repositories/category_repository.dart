import 'package:todo_app/features/todo/domain/entities/category_entity.dart';

abstract class CategoryRepository {

  Future<CategoryEntity?> getCategoryById(int id);

  Stream<List<CategoryEntity>> getCategories();

  Future<void> createCategory(CategoryEntity category);

  Future<void> updateCategory(CategoryEntity category);

  Future<void> deleteCategory(CategoryEntity category);

}