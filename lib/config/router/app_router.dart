import 'package:flutter/material.dart';
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

import 'package:todo_app/features/todo/domain/use_cases/event/get_events_usecase.dart';
import 'package:todo_app/features/todo/domain/use_cases/event/create_event_usecase.dart';
import 'package:todo_app/features/todo/domain/use_cases/event/update_event_usecase.dart';
import 'package:todo_app/features/todo/domain/use_cases/event/delete_event_usecase.dart';
import 'package:todo_app/features/todo/domain/use_cases/event/add_event_notification_usecase.dart';
import 'package:todo_app/features/todo/domain/use_cases/event/get_event_notifications_usecase.dart';
import 'package:todo_app/features/todo/domain/use_cases/event/delete_event_notifications_usecase.dart';

import 'package:todo_app/features/todo/domain/use_cases/category/get_categories_usecase.dart';
import 'package:todo_app/features/todo/domain/use_cases/category/create_category_usecase.dart';
import 'package:todo_app/features/todo/domain/use_cases/category/update_category_usecase.dart';
import 'package:todo_app/features/todo/domain/use_cases/category/delete_category_usecase.dart';
import 'package:todo_app/features/todo/domain/use_cases/event/count_tasks_by_category_usecase.dart';
import 'package:todo_app/features/todo/domain/use_cases/event/delete_tasks_by_category_usecase.dart';
import 'package:todo_app/features/todo/domain/use_cases/event/remove_category_from_tasks_usecase.dart';


TodoBloc _createTodoBloc(BuildContext context) {
  final repo = context.read<EventRepository>();
  return TodoBloc(
    getEvents: GetEventsUseCase(repo),
    createEvent: CreateEventUseCase(repo),
    updateEvent: UpdateEventUseCase(repo),
    deleteEvent: DeleteEventUseCase(repo),
    addNotification: AddEventNotificationUseCase(repo),
    getNotifications: GetEventNotificationsUseCase(repo),
    deleteNotifications: DeleteEventNotificationsUseCase(repo),
  );
}

CategoryBloc _createCategoryBloc(BuildContext context) {
  final eventRepo = context.read<EventRepository>();
  final categoryRepo = context.read<CategoryRepository>();
  return CategoryBloc(
    getCategories: GetCategoriesUseCase(categoryRepo),
    createCategory: CreateCategoryUseCase(categoryRepo),
    updateCategory: UpdateCategoryUseCase(categoryRepo),
    deleteCategory: DeleteCategoryUseCase(categoryRepo),
    countTasksByCategory: CountTasksByCategoryUseCase(eventRepo),
    deleteTasksByCategory: DeleteTasksByCategoryUseCase(eventRepo),
    removeCategoryFromTasks: RemoveCategoryFromTasksUseCase(eventRepo),
  );
}

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
                  create: (context) => _createTodoBloc(context)
                    ..add(const TodoSubscriptionRequested(isDone: false)),
                  
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
                  create: (context) => _createTodoBloc(context)
                    ..add(const TodoSubscriptionRequested(isDone: true)),

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
                return BlocProvider(
                  create: (context) => _createCategoryBloc(context)
                    ..add(SubscribeToCategories()),
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
      pageBuilder: (context, state) { 
        final taskToEdit = state.extra as EventEntity?;
        return CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: const Duration(milliseconds: 400),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => _createTodoBloc(context),
              ),
              BlocProvider(
                create: (context) => _createCategoryBloc(context)
                  ..add(SubscribeToCategories()),
              ),
            ],
            child: TaskScreen(event: taskToEdit),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final offsetAnimation = Tween<Offset>(
              begin: const Offset(0, 0.12),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ));
            return SlideTransition(
              position: offsetAnimation,
              child: FadeTransition(
                opacity: CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOut,
                ),
                child: child,
              ),
            );
          },
        );
      },
    ),

  ]

);