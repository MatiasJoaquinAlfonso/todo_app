import 'package:flutter/material.dart';
import 'package:todo_app/config/theme/app_theme.dart';
import 'package:todo_app/features/screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do App',
      theme: AppTheme(selectedColor: 0).getTheme(),
      home: HomePage(),
    );
  }
}
