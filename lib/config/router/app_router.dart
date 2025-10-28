import 'package:go_router/go_router.dart';
import 'package:todo_app/features/screens/screens.dart';
import 'package:todo_app/features/shared/widgets/widgets.dart';



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
              routes: [
                GoRoute(
                  path: '/task-screen',
                  builder: (context, state) => TaskScreen(),
                ),
              ]

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



  ]



);