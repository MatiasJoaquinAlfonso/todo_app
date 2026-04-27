import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:todo_app/features/calendar_sync/domain/repositories/calendar_sync_repository.dart';
import 'package:todo_app/features/todo/domain/entities/event_entity.dart';
import 'calendar_sync_state.dart';

export 'calendar_sync_state.dart';

/// Cubit que maneja la autenticación con Google y la sincronización
/// de tareas con Google Calendar.
class CalendarSyncCubit extends Cubit<CalendarSyncState> {
  final CalendarSyncRepository _repository;
  final Logger _logger = Logger();

  CalendarSyncCubit({required CalendarSyncRepository repository})
      : _repository = repository,
        super(const CalendarSyncState());

  /// Inicializa el cubit verificando si ya hay una sesión activa
  Future<void> init() async {
    try {
      final isSignedIn = await _repository.isSignedIn();
      if (isSignedIn && _repository.currentUserEmail != null) {
        emit(CalendarSyncState(
          authStatus: GoogleAuthStatus.connected,
          userEmail: _repository.currentUserEmail,
          userDisplayName: _repository.currentUserDisplayName,
          userPhotoUrl: _repository.currentUserPhotoUrl,
        ));
        _logger.i('Google Calendar: Sesión restaurada para ${_repository.currentUserEmail}');
      }
    } catch (e) {
      _logger.w('Google Calendar: No se pudo restaurar sesión: $e');
    }
  }

  /// Inicia sesión con Google
  Future<void> signIn() async {
    emit(state.copyWith(authStatus: GoogleAuthStatus.connecting));

    try {
      final success = await _repository.signIn();
      if (success) {
        emit(CalendarSyncState(
          authStatus: GoogleAuthStatus.connected,
          userEmail: _repository.currentUserEmail,
          userDisplayName: _repository.currentUserDisplayName,
          userPhotoUrl: _repository.currentUserPhotoUrl,
        ));
        _logger.i('Google Calendar: Login exitoso → ${_repository.currentUserEmail}');
      } else {
        emit(const CalendarSyncState(
          authStatus: GoogleAuthStatus.disconnected,
          errorMessage: 'No se pudo iniciar sesión con Google.',
        ));
        _logger.w('Google Calendar: Login cancelado o fallido');
      }
    } catch (e) {
      emit(CalendarSyncState(
        authStatus: GoogleAuthStatus.error,
        errorMessage: 'Error al conectar: $e',
      ));
      _logger.e('Google Calendar: Error en signIn: $e');
    }
  }

  /// Cierra sesión con Google
  Future<void> signOut() async {
    try {
      await _repository.signOut();
      emit(const CalendarSyncState(authStatus: GoogleAuthStatus.disconnected));
      _logger.i('Google Calendar: Sesión cerrada');
    } catch (e) {
      _logger.e('Google Calendar: Error en signOut: $e');
    }
  }

  /// Sincroniza un evento local con Google Calendar
  /// Retorna el googleEventId si la sincronización fue exitosa
  Future<String?> syncEvent(EventEntity event) async {
    if (!state.isConnected) return null;

    emit(state.copyWith(isSyncing: true));
    try {
      String? googleEventId;

      if (event.googleEventId != null && event.googleEventId!.isNotEmpty) {
        // Actualizar evento existente
        await _repository.updateEventInGoogle(event.googleEventId!, event);
        googleEventId = event.googleEventId;
        _logger.i('Google Calendar: Evento actualizado → ${event.title}');
      } else {
        // Crear evento nuevo
        googleEventId = await _repository.syncEventToGoogle(event);
        _logger.i('Google Calendar: Evento creado → ${event.title} (ID: $googleEventId)');
      }

      emit(state.copyWith(isSyncing: false));
      return googleEventId;
    } catch (e) {
      emit(state.copyWith(isSyncing: false, errorMessage: 'Error al sincronizar: $e'));
      _logger.e('Google Calendar: Error al sincronizar evento: $e');
      return null;
    }
  }

  /// Elimina un evento de Google Calendar
  Future<void> deleteGoogleEvent(String googleEventId) async {
    if (!state.isConnected) return;

    try {
      await _repository.deleteEventFromGoogle(googleEventId);
      _logger.i('Google Calendar: Evento eliminado → $googleEventId');
    } catch (e) {
      _logger.e('Google Calendar: Error al eliminar evento: $e');
    }
  }
}
