import 'package:flutter/material.dart';

const colorList = <Color>[
  Colors.blue,
  Colors.deepPurple,
  Colors.red,
];

class AppTheme {

  final int selectedColor;
  final bool isDarkMode;

  AppTheme({
    this.isDarkMode = false,
    this.selectedColor = 0,
  }): assert(selectedColor >= 0, 'El color seleccionado no es valido.');

  ThemeData getTheme() {
    
    final colorScheme = ColorScheme.fromSeed(
        seedColor: colorList[selectedColor],
        brightness: isDarkMode ?  Brightness.dark : Brightness.light,
      );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,

      // scaffoldBackgroundColor: isDarkMode ? null : Colors.white60,

      appBarTheme: AppBarTheme(
        centerTitle: true,
        // backgroundColor: isDarkMode? null : Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.primary),
        titleTextStyle: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black87,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),

      cardTheme: CardThemeData(
        color: isDarkMode ? null : Colors.white30,
        elevation: 2, 
        shadowColor: Colors.black12, 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),

      textTheme: TextTheme(
        titleLarge: TextStyle(fontWeight: FontWeight.bold),
      )

    );

  }

  AppTheme copyWith({
    int? selectedColor,
    bool? isDarkMode,
  }) => AppTheme(
    selectedColor: selectedColor?? this.selectedColor,
    isDarkMode: isDarkMode?? this.isDarkMode,
  );

}