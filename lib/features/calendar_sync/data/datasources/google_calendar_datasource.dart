import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/features/todo/domain/entities/event_entity.dart';

/// Cliente HTTP personalizado que añade headers de autenticación
class GoogleHttpClient extends http.BaseClient {
  final Map<String, String> _headers;
  final http.Client _client = http.Client();

  GoogleHttpClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
    return _client.send(request);
  }

}

/// Datasource para interactuar con Google Calendar API
class GoogleCalendarDatasource {
  final GoogleSignIn _googleSignIn;

  GoogleCalendarDatasource({GoogleSignIn? googleSignIn})
      : _googleSignIn = googleSignIn ?? GoogleSignIn(
          scopes: [
            'https://www.googleapis.com/auth/calendar.events',
          ],
        );

  /// Obtiene el cliente de la API de Calendar autenticado
  Future<calendar.CalendarApi> _getCalendarApi() async {
    final user = _googleSignIn.currentUser;
    if (user == null) {
      throw Exception('Usuario no autenticado');
    }

    final authHeaders = await user.authHeaders;
    final client = GoogleHttpClient(authHeaders);
    return calendar.CalendarApi(client);
  }

  /// Inserta un evento en Google Calendar
  /// Retorna el ID del evento de Google
  Future<String> insertEvent(EventEntity event) async {
    try {
      final calendarApi = await _getCalendarApi();

      final googleEvent = calendar.Event()
        ..summary = event.title
        ..description = event.description
        ..location = event.subTitle
        ..start = calendar.EventDateTime(
          dateTime: event.dateInit.toUtc(),
          timeZone: 'UTC',
        )
        ..end = calendar.EventDateTime(
          dateTime: event.dateFinish.toUtc(),
          timeZone: 'UTC',
        );

      final createdEvent = await calendarApi.events.insert(googleEvent, 'primary');
      return createdEvent.id ?? '';
    } catch (e) {
      throw Exception('Error insertando evento en Google Calendar: $e');
    }
  }

  /// Actualiza un evento en Google Calendar
  Future<void> updateEvent(String googleEventId, EventEntity event) async {
    try {
      final calendarApi = await _getCalendarApi();

      final googleEvent = calendar.Event()
        ..summary = event.title
        ..description = event.description
        ..location = event.subTitle
        ..start = calendar.EventDateTime(
          dateTime: event.dateInit.toUtc(),
          timeZone: 'UTC',
        )
        ..end = calendar.EventDateTime(
          dateTime: event.dateFinish.toUtc(),
          timeZone: 'UTC',
        );

      await calendarApi.events.update(googleEvent, 'primary', googleEventId);
    } catch (e) {
      throw Exception('Error actualizando evento en Google Calendar: $e');
    }
  }

  /// Elimina un evento de Google Calendar
  Future<void> deleteEvent(String googleEventId) async {
    try {
      final calendarApi = await _getCalendarApi();
      await calendarApi.events.delete('primary', googleEventId);
    } catch (e) {
      throw Exception('Error eliminando evento en Google Calendar: $e');
    }
  }
}
