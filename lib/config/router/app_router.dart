import 'package:go_router/go_router.dart';
import 'package:todo_app/features/screens/screens.dart';



final appRouter = GoRouter(

  routes: [

    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
    ),

    GoRoute(
      path: '/task-screen',
      builder: (context, state) => TaskScreen(),
    ),

  ]



);