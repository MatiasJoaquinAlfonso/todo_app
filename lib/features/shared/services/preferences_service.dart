import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Clave base para guardar a qué hora le gusta al usuario X categoría
  // Ej: guardaremos -> 'category_pref_1': 'morning'
  static Future<void> saveCategoryTimePreference(int categoryId, String timePref) async {
    await _prefs.setString('category_pref_$categoryId', timePref);
  }

  // Leer la preferencia. Si no tiene, devuelve 'none' por defecto
  static String getCategoryTimePreference(int categoryId) {
    return _prefs.getString('category_pref_$categoryId') ?? 'none';
  }
}
