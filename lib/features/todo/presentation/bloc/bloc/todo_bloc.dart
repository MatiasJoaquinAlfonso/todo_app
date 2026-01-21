import 'package:drift/drift.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/features/database/database.dart';
import 'package:todo_app/features/shared/services/notification_service.dart';
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
    final int taskId;
    
    try {
      taskId = await _repository.saveEvent(event.event);  

      final difference = event.event.dateFinish.difference(event.event.dateInit).inDays;

      final int daysToSchedule = difference == 0 ? 1 : difference + 1;

      for(int i=0; i < daysToSchedule; i++){

        DateTime alertDate = event.event.dateInit.add(Duration(days: i));
        
        if(event.event.isAllDay){
          alertDate = DateTime(alertDate.year, alertDate.month, alertDate.day, 9, 0);
        }else{
          alertDate = DateTime(
            alertDate.year,
            alertDate.month,
            alertDate.day,
            event.event.dateInit.hour,
            event.event.dateInit.minute,
          );
        }

        final notificationData = NotificationTableCompanion(
          eventId: Value(taskId),
          scheduleDate: Value(alertDate),
        );

        final int notificationId = await _repository.addNotification(notificationData);

        final String bodyText = (event.event.description != null && event.event.description!.isNotEmpty)
            ? event.event.description!
            : "Tienes una tarea pendiente.";

        await NotificationService().scheduleNotification(
          id: notificationId, 
          title: event.event.title, 
          body: bodyText,
          scheduledDate: alertDate
        );

      }

    } catch (e) {
      emit(TodoError("Error al guardar tarea: $e"));
    }
    
  }

  Future<void> _onDeleted(
    TodoDeleted event,
    Emitter<TodoState> emit,
  ) async {
    
    try {
      if (event.event.id != null){
        final idNotifications = await _repository.getNotifications(event.event.id!);
        for (final notification in idNotifications) {
          await NotificationService().cancelNotification(notification.id);
        }
      }

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