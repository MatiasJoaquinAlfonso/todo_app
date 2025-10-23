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

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    brightness: isDarkMode ?  Brightness.dark : Brightness.light,
    colorSchemeSeed: colorList[selectedColor],
    appBarTheme: AppBarTheme(centerTitle: false,)
    // useSystemColors: 
  ); 

  AppTheme copyWith({
    int? selectedColor,
    bool? isDarkMode,
  }) => AppTheme(
    selectedColor: selectedColor?? this.selectedColor,
    isDarkMode: isDarkMode?? this.isDarkMode,
  );

}