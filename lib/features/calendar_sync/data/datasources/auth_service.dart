import 'package:google_sign_in/google_sign_in.dart';

/// Servicio de autenticación con Google
/// Maneja el flujo OAuth2 para acceder a Google Calendar
class AuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/calendar.events',
    ],
  );

  /// Inicia sesión con Google
  /// Retorna true si el login fue exitoso
  Future<bool> signIn() async {
    try {
      await _googleSignIn.signIn();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Cierra sesión
  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }

  /// Verifica si el usuario está logueado
  bool get isLoggedIn => _googleSignIn.currentUser != null;

  /// Obtiene el usuario actual
  GoogleSignInAccount? get currentUser => _googleSignIn.currentUser;

  /// Obtiene los headers de autenticación para las peticiones HTTP
  Future<Map<String, String>?> get authHeaders async {
    final user = _googleSignIn.currentUser;
    if (user == null) return null;
    return await user.authHeaders;
  }

  /// Obtiene el token de acceso
  Future<String?> get accessToken async {
    final user = _googleSignIn.currentUser;
    if (user == null) return null;
    final auth = await user.authentication;
    return auth.accessToken;
  }

  /// Obtiene el ID token
  Future<String?> get idToken async {
    final user = _googleSignIn.currentUser;
    if (user == null) return null;
    final auth = await user.authentication;
    return auth.idToken;
  }

  /// Dispara el flujo de autenticación silenciosamente
  /// Útil para verificar si ya hay una sesión activa
  Future<bool> trySilentSignIn() async {
    try {
      await _googleSignIn.signInSilently();
      return true;
    } catch (e) {
      return false;
    }
  }
}
