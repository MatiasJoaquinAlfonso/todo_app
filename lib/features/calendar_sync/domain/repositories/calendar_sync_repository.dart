import 'package:todo_app/features/todo/domain/entities/event_entity.dart';

/// Contrato para el repositorio de sincronización con Google Calendar
abstract class CalendarSyncRepository {
  /// Inicia sesión con Google
  Future<bool> signIn();

  /// Cierra la sesión de Google
  Future<void> signOut();

  /// Verifica si hay una sesión activa
  Future<bool> isSignedIn();

  /// Intenta login silencioso (restaurar sesión previa)
  Future<bool> trySilentSignIn();

  /// Obtiene el email del usuario logueado
  String? get currentUserEmail;

  /// Obtiene el nombre del usuario logueado
  String? get currentUserDisplayName;

  /// Obtiene la foto del usuario logueado
  String? get currentUserPhotoUrl;

  /// Inserta un evento en Google Calendar y retorna el googleEventId
  Future<String> syncEventToGoogle(EventEntity event);

  /// Actualiza un evento existente en Google Calendar
  Future<void> updateEventInGoogle(String googleEventId, EventEntity event);

  /// Elimina un evento de Google Calendar
  Future<void> deleteEventFromGoogle(String googleEventId);
}
