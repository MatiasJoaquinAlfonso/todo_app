import 'package:equatable/equatable.dart';

/// Estados posibles de la conexión con Google Calendar
enum GoogleAuthStatus { disconnected, connecting, connected, error }

class CalendarSyncState extends Equatable {
  final GoogleAuthStatus authStatus;
  final String? userEmail;
  final String? userDisplayName;
  final String? userPhotoUrl;
  final String? errorMessage;
  final bool isSyncing;

  const CalendarSyncState({
    this.authStatus = GoogleAuthStatus.disconnected,
    this.userEmail,
    this.userDisplayName,
    this.userPhotoUrl,
    this.errorMessage,
    this.isSyncing = false,
  });

  bool get isConnected => authStatus == GoogleAuthStatus.connected;

  CalendarSyncState copyWith({
    GoogleAuthStatus? authStatus,
    String? userEmail,
    String? userDisplayName,
    String? userPhotoUrl,
    String? errorMessage,
    bool? isSyncing,
  }) {
    return CalendarSyncState(
      authStatus: authStatus ?? this.authStatus,
      userEmail: userEmail ?? this.userEmail,
      userDisplayName: userDisplayName ?? this.userDisplayName,
      userPhotoUrl: userPhotoUrl ?? this.userPhotoUrl,
      errorMessage: errorMessage ?? this.errorMessage,
      isSyncing: isSyncing ?? this.isSyncing,
    );
  }

  @override
  List<Object?> get props => [authStatus, userEmail, userDisplayName, userPhotoUrl, errorMessage, isSyncing];
}
