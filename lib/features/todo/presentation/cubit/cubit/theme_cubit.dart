import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(themeMode: ThemeMode.system));

  static const String _themePrefsKey = 'theme_mode_index';

  Future<void> _loadTheme () async {
    final prefs = await SharedPreferences.getInstance();

    final int? savedThemeIndex = prefs.getInt(_themePrefsKey);

    if (savedThemeIndex == null) {
      const defaultMode = ThemeMode.system;

      await prefs.setInt(_themePrefsKey, defaultMode.index);

      emit(const ThemeState(themeMode: defaultMode));

    } else {
      final savedMode = ThemeMode.values[savedThemeIndex];
      emit(ThemeState(themeMode: savedMode));
    }

  }

  Future<void> updateTheme (ThemeMode newMode) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(_themePrefsKey, newMode.index);
    emit(ThemeState(themeMode: newMode));
  }

  void toggleTheme () {
    final isDark = state.themeMode == ThemeMode.dark;
    updateTheme(isDark? ThemeMode.light : ThemeMode.dark);
  }


}
