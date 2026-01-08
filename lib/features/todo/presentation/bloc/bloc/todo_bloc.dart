import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/features/todo/domain/entities/event_entity.dart';
import 'package:todo_app/features/todo/domain/repositories/event_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final EventRepository _repository;

  TodoBloc({required EventRepository repository})
    : _repository = repository,
      super(TodoInitial()) {

    on<TodoSubscriptionRequested>(_onSubscriptionRequested);
    on<TodoAdded>(_onAdded);
    on<TodoDeleted>(_onDeleted);
    on<TodoUpdated>(_onUpdated);

  }

  Future<void> _onSubscriptionRequested(
    TodoSubscriptionRequested event,
    Emitter<TodoState> emit,
  ) async {
    
    emit(TodoLoading());

    await emit.forEach<List<EventEntity>>(
      _repository.getEvents(), 
      onData: (tasks) => TodoLoaded(tasks),
      onError: (error, stackTrace) => TodoError(error.toString()),
    );

  }

  Future<void> _onAdded(
    TodoAdded event,
    Emitter<TodoState> emit,
  ) async {
    
    try {
      await _repository.saveEvent(event.event);  
    } catch (e) {
      emit(TodoError("Error al guardar tarea: $e"));
    }
    
  }

  Future<void> _onDeleted(
    TodoDeleted event,
    Emitter<TodoState> emit,
  ) async {
    
    try {
      await _repository.deleteEvent(event.event);  
    } catch (e) {
      emit(TodoError("Error al borrar la tarea: $e"));
    }

  }

  Future<void> _onUpdated(
    TodoUpdated event,
    Emitter<TodoState> emit,
  ) async {
    
    try {
      await _repository.updateEvent(event.event);  
    } catch (e) {
      emit(TodoError("Error al actualizar la tarea: $e"));
    }    
  }
 

}
