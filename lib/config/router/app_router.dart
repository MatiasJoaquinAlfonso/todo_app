import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/features/screens/categories_screen.dart';
import 'package:todo_app/features/screens/screens.dart';
import 'package:todo_app/features/shared/widgets/widgets.dart';
import 'package:todo_app/features/todo/domain/entities/event_entity.dart';
import 'package:todo_app/features/todo/domain/repositories/category_repository.dart';
import 'package:todo_app/features/todo/domain/repositories/event_repository.dart';
import 'package:todo_app/features/todo/presentation/bloc/categories_bloc/bloc/category_bloc.dart';
import 'package:todo_app/features/todo/presentation/bloc/todo_bloc.dart';



final appRouter = GoRouter(
  initialLocation: '/',
  routes: [

    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return BottomNavBar(navigationBar: navigationShell);
      },

      branches: [

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) {
                return BlocProvider(
                  create: (context) => TodoBloc(
                    repository: context.read<EventRepository>()
                  )..add(const TodoSubscriptionRequested(isDone: false)),
                  
                  child: const HomePage(),
                );
              },
            ),

          ]
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/task_finish',
              builder: (context, state) {
                return BlocProvider(
                  create: (context) => TodoBloc(
                    repository: context.read<EventRepository>()
                  )..add(const TodoSubscriptionRequested(isDone: true)),

                  child: const TaskFinishScreen(),
                );
              },
            ),
          ]
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/categories',
              builder: (context, state) {
                final eventRepository = context.read<EventRepository>();
                final categoryRepository = context.read<CategoryRepository>();

                return BlocProvider(
                  create: (context) => CategoryBloc(
                    eventRepository: eventRepository, 
                    categoryRepository: categoryRepository
                  )..add(SubscribeToCategories()),
                  child: const CategoriesScreen(),
                );
              },
            ),
          ]
        ),      

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => SettingsScreen(),
            ),
          ]
        ),        

      ]
    ),


    GoRoute(
      path: '/task-screen',
      builder: (context, state) { 
        final taskToEdit = state.extra as EventEntity?;
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => TodoBloc(
                repository: context.read<EventRepository>()
              ),
            ),
            BlocProvider(
              create: (context) => CategoryBloc(
                eventRepository: context.read<EventRepository>(), 
                categoryRepository: context.read<CategoryRepository>()
              )..add(SubscribeToCategories()),
            ),
          ],
          child: TaskScreen(event: taskToEdit),
        );
      },
    ),

  ]

);