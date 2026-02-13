part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

// TODO: cargar la lista de categorias iniciales.
final class SubscribeToCategories extends CategoryEvent {}

final class CreateCategory extends CategoryEvent {
  final CategoryEntity category;

  const CreateCategory(this.category);
}

final class RequestDeleteCategory extends CategoryEvent {
  final CategoryEntity category;

  const RequestDeleteCategory(this.category);
}

final class ConfirmDeleteCategory extends CategoryEvent {
  final CategoryEntity category;
  final bool deleteTasks;

  const ConfirmDeleteCategory({
    required this.category, 
    required this.deleteTasks
  });
}

final class ValidateCategoryName extends CategoryEvent {
  final String name;

  const ValidateCategoryName(this.name);
}