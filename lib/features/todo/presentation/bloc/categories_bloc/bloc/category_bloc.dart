import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/features/todo/domain/entities/category_entity.dart';
import 'package:todo_app/features/todo/domain/repositories/category_repository.dart';
import 'package:todo_app/features/todo/domain/repositories/event_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final EventRepository _eventRepository;
  final CategoryRepository _categoryRepository;

  CategoryBloc({required CategoryRepository categoryRepository, EventRepository eventRepository}) 
    : _categoryRepository = categoryRepository,
      _eventRepository = eventRepository,
      super(CategoryInitial()) {

    // on<CategoryEvent>((event, emit) {});
    // on<RequestDeleteCategory>(_onDeletedRequest);

  }
}


// Future<void> _onDeletedRequest(
//   RequestDeleteCategory category,
//   Emmiter<CategoryState> emit,
// ) async {

// }
