import 'package:drift/drift.dart';
import 'package:todo_app/features/database/database.dart';
import 'package:todo_app/features/todo/domain/entities/category_entity.dart';

extension CategoryMapper on CategoriesTableData {
  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id, 
      title: title, 
      color: color, 
      priority: priority,
    );
  }
}


extension CategoryEntityMapper on CategoryEntity {
  CategoriesTableCompanion toCompanion() {
    return CategoriesTableCompanion(
      id: id != null ? Value(id!) : const Value.absent(), 
      title: Value(title), 
      color: Value(color), 
      priority: Value(priority),
    );
  }

}