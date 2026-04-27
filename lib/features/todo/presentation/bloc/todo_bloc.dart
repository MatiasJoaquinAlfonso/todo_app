import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/features/calendar_sync/presentation/cubit/calendar_sync_cubit.dart';
import 'package:todo_app/features/shared/services/notification_service.dart';
import 'package:todo_app/features/todo/domain/entities/event_entity.dart';
import 'package:todo_app/features/todo/domain/entities/notification_entity.dart';
import 'package:todo_app/features/todo/domain/use_cases/event/get_events_usecase.dart';
import 'package:todo_app/features/todo/domain/use_cases/event/create_event_usecase.dart';
import 'package:todo_app/features/todo/domain/use_cases/event/update_event_usecase.dart';
import 'package:todo_app/features/todo/domain/use_cases/event/delete_event_usecase.dart';
import 'package:todo_app/features/todo/domain/use_cases/event/add_event_notification_usecase.dart';
import 'package:todo_app/features/todo/domain/use_cases/event/get_event_notifications_usecase.dart';
import 'package:todo_app/features/todo/domain/use_cases/event/delete_event_notifications_usecase.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetEventsUseCase _getEvents;
  final CreateEventUseCase _createEvent;
  final UpdateEventUseCase _updateEvent;
  final DeleteEventUseCase _deleteEvent;
  final AddEventNotificationUseCase _addNotification;
  final GetEventNotificationsUseCase _getNotifications;
  final DeleteEventNotificationsUseCase _deleteNotifications;
  final CalendarSyncCubit? _calendarSyncCubit;

  TodoBloc({
    required GetEventsUseCase getEvents,
    required CreateEventUseCase createEvent,
    required UpdateEventUseCase updateEvent,
    required DeleteEventUseCase deleteEvent,
    required AddEventNotificationUseCase addNotification,
    required GetEventNotificationsUseCase getNotifications,
    required DeleteEventNotificationsUseCase deleteNotifications,
    CalendarSyncCubit? calendarSyncCubit,
  }) : _getEvents = getEvents,
       _createEvent = createEvent,
       _updateEvent = updateEvent,
       _deleteEvent = deleteEvent,
       _addNotification = addNotification,
       _getNotifications = getNotifications,
       _deleteNotifications = deleteNotifications,
       _calendarSyncCubit = calendarSyncCubit,
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
      _getEvents(isDone: event.isDone),
      onData: (tasks) => TodoLoaded(tasks),
      onError: (error, stackTrace) => TodoError(error.toString()),
    );
  }

  Future<void> _onAdded(
    TodoAdded event,
    Emitter<TodoState> emit,
  ) async {
    try {
      final int taskId = await _createEvent(event.event);
      await _scheduleNotifications(taskId, event.event);

      // Sincronizar con Google Calendar si está habilitado
      final syncCubit = _calendarSyncCubit;
      if (event.event.isSynced && syncCubit != null && syncCubit.state.isConnected) {
        final googleEventId = await syncCubit.syncEvent(event.event);
        if (googleEventId != null) {
          // Actualizar el evento local con el ID de Google
          final syncedEvent = event.event.copyWith(
            id: taskId,
            googleEventId: googleEventId,
            isSynced: true,
            lastSyncedAt: DateTime.now(),
            syncStatus: 'synced',
          );
          await _updateEvent(syncedEvent);
        }
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
      if (event.event.id == null) return;

      // Eliminar de Google Calendar si estaba sincronizado
      final syncCubit = _calendarSyncCubit;
      if (event.event.googleEventId != null && 
          event.event.googleEventId!.isNotEmpty &&
          syncCubit != null &&
          syncCubit.state.isConnected) {
        await syncCubit.deleteGoogleEvent(event.event.googleEventId!);
      }

      await _deleteSecheduleNotification(event.event.id!);
      await _deleteEvent(event.event);
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

      // Sincronizar con Google Calendar si está habilitado
      final syncCubit = _calendarSyncCubit;
      if (event.event.isSynced && syncCubit != null && syncCubit.state.isConnected) {
        final googleEventId = await syncCubit.syncEvent(event.event);
        if (googleEventId != null) {
          final syncedEvent = event.event.copyWith(
            googleEventId: googleEventId,
            lastSyncedAt: DateTime.now(),
            syncStatus: 'synced',
          );
          await _updateEvent(syncedEvent);
        } else {
          await _updateEvent(event.event);
        }
      } else {
        await _updateEvent(event.event);
      }

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

    for(int i = 0; i < daysToSchedule; i++){
      DateTime alertDate = event.dateInit.add(Duration(days: i));
      
      if(event.isAllDay){
        alertDate = DateTime(alertDate.year, alertDate.month, alertDate.day, 9, 0);
      } else {
        alertDate = DateTime(
          alertDate.year,
          alertDate.month,
          alertDate.day,
          event.dateInit.hour,
          event.dateInit.minute,
        );
      }
      
      if (!alertDate.isBefore(DateTime.now())) {
        final notificationEntity = NotificationEntity(
          eventId: taskId,
          scheduleDate: alertDate,
        );
  
        final int notificationId = await _addNotification(notificationEntity);
  
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
    final notifications = await _getNotifications(taskId);

    for (final notification in notifications) {
      if (notification.id != null) {
        await NotificationService().cancelNotification(notification.id!);
      }
    }

    await _deleteNotifications(taskId);
  }
}