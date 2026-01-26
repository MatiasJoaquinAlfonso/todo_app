import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/config/router/app_router.dart';
import 'package:todo_app/config/theme/app_theme.dart';
import 'package:todo_app/features/database/database.dart';
import 'package:todo_app/features/todo/data/repositories/event_repository_impl.dart';
import 'package:todo_app/features/todo/domain/repositories/event_repository.dart';
// import 'package:todo_app/features/todo/presentation/bloc/bloc/todo_bloc.dart';
import 'package:todo_app/features/shared/services/notification_service.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  
  final NotificationService notificationService = NotificationService();
  await notificationService.init();
  //Apenas iniciamos la app solicitamos los permisos.
  notificationService.requestPermissions();

  final db = AppDatabase();

  runApp(MyApp(db: db));
}

class MyApp extends StatelessWidget {
  final AppDatabase db;

  const MyApp({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    
    return RepositoryProvider<EventRepository>(
      create: (context) => EventRepositoryImpl(db: db),
      child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'To-Do App',
          theme: AppTheme(isDarkMode: true, selectedColor: 0).getTheme(),
          routerConfig: appRouter,
        ),
    );
  }
}


// class MyApp extends StatelessWidget {
//   final AppDatabase db;

//   const MyApp({super.key, required this.db});

//   @override
//   Widget build(BuildContext context) {
    
//     return RepositoryProvider<EventRepository>(
//       create: (context) => EventRepositoryImpl(db: db),
//       child: BlocProvider(
//         create: (context) {
//           final repository = context.read<EventRepository>();
//           return TodoBloc(repository: repository)
//             ..add(TodoSubscriptionRequested());
//         },
//         child: MaterialApp.router(
//           debugShowCheckedModeBanner: false,
//           title: 'To-Do App',
//           theme: AppTheme(isDarkMode: true, selectedColor: 0).getTheme(),
//           routerConfig: appRouter,
//           // home: HomePage(),
//         ),
//       ),
//     );
//   }
// }
