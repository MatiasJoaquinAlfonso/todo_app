import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/features/todo/domain/entities/category_entity.dart';
import 'package:todo_app/features/todo/domain/repositories/category_repository.dart';
import 'package:todo_app/features/todo/domain/repositories/event_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final EventRepository _eventRepository;
  final CategoryRepository _categoryRepository;

  CategoryBloc({
    required EventRepository eventRepository, 
    required CategoryRepository categoryRepository
  }) : _categoryRepository = categoryRepository,
      _eventRepository = eventRepository,
      super(CategoryInitial()) {

    on<SubscribeToCategories>(_onSubscribeToCategories);
    on<CreateCategory>(_onAdded);
    on<UpdateCategory>(_onUpdated);
    on<RequestDeleteCategory>(_onDeletedRequest);
    on<ConfirmDeleteCategory>(_onConfirmDelete);

  }

  Future<void> _onSubscribeToCategories(
    SubscribeToCategories event,
    Emitter <CategoryState> emit,
  ) async {
    emit(CategoryLoading());

    await emit.forEach<List<CategoryEntity>>(
      _categoryRepository.getCategories(), 
      onData: (categories) => CategoryLoaded(categories),
      onError: (error, stackTrace) => CategoryError(error.toString()),
    );

  }

  Future<void> _onAdded(
    CreateCategory event,
    Emitter <CategoryState> emit,
  ) async {
    await _categoryRepository.createCategory(event.category);
  }

  Future<void> _onUpdated(
    UpdateCategory event,
    Emitter <CategoryState> emit,
  ) async {
    await _categoryRepository.updateCategory(event.category);
  }

  Future<void> _onDeletedRequest(
    RequestDeleteCategory event,
    Emitter <CategoryState> emit,
  ) async {

    final taskCount = await _eventRepository.countTaskByCategoryId(event.category.id!);

    if(taskCount > 0){
      emit(CategoryDeletionConfirmationRequired(
        category: event.category, 
        categoriesCount: taskCount
      ));

    } else {
      await _categoryRepository.deleteCategory(event.category);
    }

  }

  Future<void> _onConfirmDelete(
    ConfirmDeleteCategory event,
    Emitter <CategoryState> emit,
  ) async {

    int countTasks = 0;

    if(event.deleteTasks) {
      countTasks = await _eventRepository.deleteEventByCategoryId(event.category.id!);
      
    } else {
      await _eventRepository.updateEventCategory(event.category.id!, null);
    }
    await _categoryRepository.deleteCategory(event.category);

    emit(CategoryOperationSuccess(deletedCount: countTasks));
  }

}