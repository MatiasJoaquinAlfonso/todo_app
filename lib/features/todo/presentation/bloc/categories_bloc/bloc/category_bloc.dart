import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/features/todo/domain/entities/category_entity.dart';
import 'package:todo_app/features/todo/domain/use_cases/category/get_categories_usecase.dart';
import 'package:todo_app/features/todo/domain/use_cases/category/create_category_usecase.dart';
import 'package:todo_app/features/todo/domain/use_cases/category/update_category_usecase.dart';
import 'package:todo_app/features/todo/domain/use_cases/category/delete_category_usecase.dart';
import 'package:todo_app/features/todo/domain/use_cases/event/count_tasks_by_category_usecase.dart';
import 'package:todo_app/features/todo/domain/use_cases/event/delete_tasks_by_category_usecase.dart';
import 'package:todo_app/features/todo/domain/use_cases/event/remove_category_from_tasks_usecase.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoriesUseCase _getCategories;
  final CreateCategoryUseCase _createCategory;
  final UpdateCategoryUseCase _updateCategory;
  final DeleteCategoryUseCase _deleteCategory;
  final CountTasksByCategoryUseCase _countTasksByCategory;
  final DeleteTasksByCategoryUseCase _deleteTasksByCategory;
  final RemoveCategoryFromTasksUseCase _removeCategoryFromTasks;

  CategoryBloc({
    required GetCategoriesUseCase getCategories,
    required CreateCategoryUseCase createCategory,
    required UpdateCategoryUseCase updateCategory,
    required DeleteCategoryUseCase deleteCategory,
    required CountTasksByCategoryUseCase countTasksByCategory,
    required DeleteTasksByCategoryUseCase deleteTasksByCategory,
    required RemoveCategoryFromTasksUseCase removeCategoryFromTasks,
  }) : _getCategories = getCategories,
       _createCategory = createCategory,
       _updateCategory = updateCategory,
       _deleteCategory = deleteCategory,
       _countTasksByCategory = countTasksByCategory,
       _deleteTasksByCategory = deleteTasksByCategory,
       _removeCategoryFromTasks = removeCategoryFromTasks,
       super(CategoryInitial()) {

    on<SubscribeToCategories>(_onSubscribeToCategories);
    on<CreateCategory>(_onAdded);
    on<UpdateCategory>(_onUpdated);
    on<RequestDeleteCategory>(_onDeletedRequest);
    on<ConfirmDeleteCategory>(_onConfirmDelete);
    on<CancelDeleteCategory>(_onCancelDelete);
  }

  Future<void> _onCancelDelete(
    CancelDeleteCategory event,
    Emitter<CategoryState> emit,
  ) async {
    add(SubscribeToCategories());
  }

  Future<void> _onSubscribeToCategories(
    SubscribeToCategories event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());

    await emit.forEach<List<CategoryEntity>>(
      _getCategories(),
      onData: (categories) => CategoryLoaded(categories),
      onError: (error, stackTrace) => CategoryError(error.toString()),
    );
  }

  Future<void> _onAdded(
    CreateCategory event,
    Emitter<CategoryState> emit,
  ) async {
    await _createCategory(event.category);
  }

  Future<void> _onUpdated(
    UpdateCategory event,
    Emitter<CategoryState> emit,
  ) async {
    await _updateCategory(event.category);
  }

  Future<void> _onDeletedRequest(
    RequestDeleteCategory event,
    Emitter<CategoryState> emit,
  ) async {
    final taskCount = await _countTasksByCategory(event.category.id!);

    if (taskCount > 0) {
      emit(CategoryDeletionConfirmationRequired(
        category: event.category,
        categoriesCount: taskCount,
      ));
    } else {
      await _deleteCategory(event.category);
    }
  }

  Future<void> _onConfirmDelete(
    ConfirmDeleteCategory event,
    Emitter<CategoryState> emit,
  ) async {
    int countTasks = 0;

    if (event.deleteTasks) {
      countTasks = await _deleteTasksByCategory(event.category.id!);
    } else {
      await _removeCategoryFromTasks(event.category.id!);
    }
    
    await _deleteCategory(event.category);

    emit(CategoryOperationSuccess(deletedCount: countTasks));
  }
}