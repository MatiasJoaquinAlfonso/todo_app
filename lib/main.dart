import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/config/router/app_router.dart';
import 'package:todo_app/config/theme/app_theme.dart';
import 'package:todo_app/features/database/database.dart';
import 'package:todo_app/features/todo/data/repositories/event_repository_impl.dart';
import 'package:todo_app/features/todo/domain/repositories/event_repository.dart';
import 'package:todo_app/features/todo/presentation/bloc/bloc/todo_bloc.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();



  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppDatabase _db;
  late final EventRepository _repository;

  @override
  void initState() {
    super.initState();
    _db = AppDatabase();
    _repository = EventRepositoryImpl(db: _db);  
  }

  @override
  void dispose() {
    _db.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    
    return RepositoryProvider<EventRepository>.value(
      value: _repository,
      // create: (context) => EventRepositoryImpl(db: widget.db),
      child: BlocProvider(
        create: (context) => TodoBloc(repository: _repository)
          ..add(TodoSubscriptionRequested()),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'To-Do App',
          theme: AppTheme(isDarkMode: true, selectedColor: 0).getTheme(),
          routerConfig: appRouter,
        ),
      ),
    );
  }
}
