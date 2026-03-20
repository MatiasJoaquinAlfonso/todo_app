// import 'dart:ui';

import 'package:flutter/material.dart';

const colorList = <Color>[
  Colors.blue,
  Colors.deepPurple,
  Colors.red,
];

class AppTheme {

  final int selectedColor;
  final bool isDarkMode;
  // final Color background =  Color(0x00f2f4f7);


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

      scaffoldBackgroundColor: colorScheme.surfaceContainer,


      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.primary),
        backgroundColor: colorScheme.surfaceContainer,
        titleTextStyle: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black87,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),

      cardTheme: CardThemeData(
        color: isDarkMode ? null : Colors.white,
        elevation: 2, 
        shadowColor: Colors.black87, 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),

      textTheme: TextTheme(
        titleLarge: TextStyle(fontWeight: FontWeight.bold),
        
      ),

      iconTheme: IconThemeData(
        // color: isDarkMode ? Colors.white : Colors.black
      ),

      datePickerTheme: DatePickerThemeData(
        backgroundColor: isDarkMode ? const Color(0xFF1E1E2C) : Colors.white,
      ),

      timePickerTheme: TimePickerThemeData(
        backgroundColor: isDarkMode ? const Color(0xFF1E1E2C) : Colors.white,
        dialBackgroundColor: isDarkMode ? const Color(0xFF1E1E2C) : Colors.white,
        dayPeriodColor: Color.fromARGB(255, 101, 169, 215),
        dialHandColor: Color.fromARGB(255, 101, 169, 215),

        // elevation: ,
        // entryModeIconColor: ,
        // helpTextStyle: ,
        // hourMinuteColor: Color.fromARGB(255, 101, 169, 215),
        // inputDecorationTheme: ,
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