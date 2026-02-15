part of 'category_bloc.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();
  
  @override
  List<Object> get props => [];
}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategoryLoaded extends CategoryState {
  final List<CategoryEntity> categories;

  const CategoryLoaded(this.categories);

  @override
  List<Object> get props => [categories];
}

final class CategoryDeletionConfirmationRequired extends CategoryState {
  final CategoryEntity category;
  final int categoriesCount;

  const CategoryDeletionConfirmationRequired({
    required this.category, 
    required this.categoriesCount
  });

}

final class CategoryError extends CategoryState {
  final String message;
  const CategoryError(this.message);
}

final class CategoryOperationSuccess extends CategoryState {
  final int deletedCount;

  const CategoryOperationSuccess({required this.deletedCount});

}
