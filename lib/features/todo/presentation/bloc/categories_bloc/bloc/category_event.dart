part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

final class SubscribeToCategories extends CategoryEvent {}

final class CreateCategory extends CategoryEvent {
  final CategoryEntity category;

  const CreateCategory(this.category);

  @override
  List<Object> get props => [category];
}

final class UpdateCategory extends CategoryEvent {
  final CategoryEntity category;

  const UpdateCategory(this.category);

  @override
  List<Object> get props => [category];
}

final class RequestDeleteCategory extends CategoryEvent {
  final CategoryEntity category;

  const RequestDeleteCategory(this.category);

  @override
  List<Object> get props => [category];
}

final class ConfirmDeleteCategory extends CategoryEvent {
  final CategoryEntity category;
  final bool deleteTasks;

  const ConfirmDeleteCategory({
    required this.deleteTasks, 
    required this.category, 
  });

  @override
  List<Object> get props => [deleteTasks, category];
}

final class CancelDeleteCategory extends CategoryEvent {}

final class ValidateCategoryName extends CategoryEvent {
  final String name;

  const ValidateCategoryName(this.name);

  @override
  List<Object> get props => [name];
}