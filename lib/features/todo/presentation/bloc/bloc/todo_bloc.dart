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
      _repository.getEvents(isDone: event.isDone), 
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
      await _scheduleNotifications(taskId, event.event);

    } catch (e) {
      emit(TodoError("Error al guardar tarea: $e"));
    }
    
  }

  Future<void> _onDeleted(
    TodoDeleted event,
    Emitter<TodoState> emit,
  ) async {
    
    try {
      if (event.event.id == null) return;
   
        await _deleteSecheduleNotification(event.event.id!);
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

      if (event.event.id == null) return;

      await _deleteSecheduleNotification(event.event.id!);
      await _repository.updateEvent(event.event);  
      
      
      if (!event.event.isDone){
        await _scheduleNotifications(event.event.id!, event.event);
      }

    } catch (e) {
      emit(TodoError("Error al actualizar la tarea: $e"));
    }    
  }
 
  Future<void> _scheduleNotifications(int taskId, EventEntity event) async {

    final difference = event.dateFinish.difference(event.dateInit).inDays;

    final int daysToSchedule = difference == 0 ? 1 : difference + 1;

    for(int i=0; i < daysToSchedule; i++){

      DateTime alertDate = event.dateInit.add(Duration(days: i));
        
      if(event.isAllDay){
        alertDate = DateTime(alertDate.year, alertDate.month, alertDate.day, 9, 0);
      }else{
        alertDate = DateTime(
          alertDate.year,
          alertDate.month,
          alertDate.day,
          event.dateInit.hour,
          event.dateInit.minute,
        );
      }
      
      if (!alertDate.isBefore(DateTime.now())) {
        final notificationData = NotificationTableCompanion(
          eventId: Value(taskId),
          scheduleDate: Value(alertDate),
        );
  
        final int notificationId = await _repository.addNotification(notificationData);
  
        final String bodyText = (event.description != null && event.description!.isNotEmpty)
          ? event.description!
          : "Tienes una tarea pendiente.";
  
        await NotificationService().scheduleNotification(
          id: notificationId, 
          title: event.title, 
          body: bodyText,
          scheduledDate: alertDate
        );
      }
    }

  }



  Future<void> _deleteSecheduleNotification(int taskId) async {
    final notificationsId = await _repository.getNotifications(taskId);

    for(final notification in notificationsId){
      await NotificationService().cancelNotification(notification.id);
    }

    await _repository.deleteNotifications(taskId);
  }


}