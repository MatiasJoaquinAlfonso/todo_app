import 'package:go_router/go_router.dart';
import 'package:todo_app/features/screens/screens.dart';
import 'package:todo_app/features/shared/widgets/widgets.dart';
import 'package:todo_app/features/todo/domain/entities/event_entity.dart';



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
              builder: (context, state) => HomePage(),
            ),


          ]
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/task_finish',
              builder: (context, state) => TaskFinishScreen(),
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
        return TaskScreen(event: taskToEdit);
      },
    ),

  ]

);