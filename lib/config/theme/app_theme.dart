import 'package:flutter/material.dart';

const colorList = <Color>[
  Colors.blue,
  Colors.red,
];

class AppTheme {

  final int selectedColor;

  AppTheme({
    this.selectedColor = 0,
  }): assert(selectedColor >= 0, 'El color seleccionado no es valido.');

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: colorList[selectedColor],
    // useSystemColors: 
  ); 

}