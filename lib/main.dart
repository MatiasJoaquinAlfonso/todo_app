import 'package:flutter/material.dart';
import 'package:todo_app/config/router/app_router.dart';
import 'package:todo_app/config/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'To-Do App',
      theme: AppTheme(isDarkMode: true, selectedColor: 0).getTheme(),
      routerConfig: appRouter,
      // home: HomePage(),
    );
  }
}
