import 'package:todo_app/features/database/database.dart';
import 'package:todo_app/features/todo/data/mappers/category_mapper.dart';
import 'package:todo_app/features/todo/domain/entities/category_entity.dart';
import 'package:todo_app/features/todo/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  
  final AppDatabase db;

  CategoryRepositoryImpl({required this.db});

  @override
  Future<void> createCategory(CategoryEntity category) async {
    await db.insertCategory(category.toCompanion());
  }

  @override
  Future<void> deleteCategory(CategoryEntity category) async {
    await db.deleteCategory(category.toCompanion());
  }

  @override
  Stream<List<CategoryEntity>> getCategories() {
    final query = db.select(db.categoriesTable);
    return query.watch().map((driftList) {
      return driftList.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<CategoryEntity?> getCategoryById(int id) async {
    final query = db.select(db.categoriesTable)..where((tbl) => tbl.id.equals(id));
    final result = await query.getSingleOrNull();
    return result?.toEntity();
  }

  @override
  Future<void> updateCategory(CategoryEntity category) async {
    await db.updateCategory(category.toCompanion());
  }
}