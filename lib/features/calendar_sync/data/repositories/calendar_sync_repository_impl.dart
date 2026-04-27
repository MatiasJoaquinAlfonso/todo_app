import 'package:todo_app/features/calendar_sync/data/datasources/auth_service.dart';
import 'package:todo_app/features/calendar_sync/data/datasources/google_calendar_datasource.dart';
import 'package:todo_app/features/calendar_sync/domain/repositories/calendar_sync_repository.dart';
import 'package:todo_app/features/todo/domain/entities/event_entity.dart';

/// Implementación concreta del repositorio de sincronización con Google Calendar.
/// 
/// Importante: AuthService y GoogleCalendarDatasource comparten la misma instancia
/// de AuthService para garantizar que usen la misma sesión de GoogleSignIn.
class CalendarSyncRepositoryImpl implements CalendarSyncRepository {
  final AuthService _authService;
  final GoogleCalendarDatasource _calendarDatasource;

  factory CalendarSyncRepositoryImpl.create() {
    final authService = AuthService();
    return CalendarSyncRepositoryImpl._(authService: authService);
  }

  CalendarSyncRepositoryImpl._({required AuthService authService})
      : _authService = authService,
        _calendarDatasource = GoogleCalendarDatasource(authService: authService);

  @override
  Future<bool> signIn() async {
    return await _authService.signIn();
  }

  @override
  Future<void> signOut() async {
    await _authService.signOut();
  }

  @override
  Future<bool> isSignedIn() async {
    if (_authService.isLoggedIn) return true;
    return await _authService.trySilentSignIn();
  }

  @override
  Future<bool> trySilentSignIn() async {
    return await _authService.trySilentSignIn();
  }

  @override
  String? get currentUserEmail => _authService.currentUser?.email;

  @override
  String? get currentUserDisplayName => _authService.currentUser?.displayName;

  @override
  String? get currentUserPhotoUrl => _authService.currentUser?.photoUrl;

  @override
  Future<String> syncEventToGoogle(EventEntity event) async {
    return await _calendarDatasource.insertEvent(event);
  }

  @override
  Future<void> updateEventInGoogle(String googleEventId, EventEntity event) async {
    await _calendarDatasource.updateEvent(googleEventId, event);
  }

  @override
  Future<void> deleteEventFromGoogle(String googleEventId) async {
    await _calendarDatasource.deleteEvent(googleEventId);
  }
}
