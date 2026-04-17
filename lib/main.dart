import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/config/router/app_router.dart';
import 'package:todo_app/config/theme/app_theme.dart';
import 'package:todo_app/features/database/database.dart';
import 'package:todo_app/features/shared/services/preferences_service.dart';
import 'package:todo_app/features/todo/data/repositories/category_repository_impl.dart';
import 'package:todo_app/features/todo/data/repositories/event_repository_impl.dart';
import 'package:todo_app/features/todo/domain/repositories/category_repository.dart';
import 'package:todo_app/features/todo/domain/repositories/event_repository.dart';
import 'package:todo_app/features/shared/services/notification_service.dart';
import 'package:todo_app/features/todo/presentation/cubit/theme_cubit/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesService.init();

  final NotificationService notificationService = NotificationService();
  await notificationService.init();

  notificationService.requestPermissions();

  final db = AppDatabase();

  runApp(MyApp(db: db));
}

class MyApp extends StatelessWidget {
  final AppDatabase db;

  const MyApp({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<EventRepository>(
          create: (context) => EventRepositoryImpl(db: db),
        ),

        RepositoryProvider<CategoryRepository>(
          create: (context) => CategoryRepositoryImpl(db: db),
        ),
      ],

      child: BlocProvider(
        create: (context) => ThemeCubit(),
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'To-Do App',
              routerConfig: appRouter,
              theme: AppTheme(isDarkMode: false, selectedColor: 0).getTheme(),
              darkTheme: AppTheme(
                isDarkMode: true,
                selectedColor: 0,
              ).getTheme(),
              themeMode: state.themeMode,
            );
          },
        ),
      ),
    );
  }
}
