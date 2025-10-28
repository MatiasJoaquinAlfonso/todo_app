import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class BottomNavBar extends StatelessWidget {

  final StatefulNavigationShell navigationBar;

  const BottomNavBar({
    super.key, 
    required this.navigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: navigationBar,

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),

        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          child: BottomNavigationBar(
            currentIndex: navigationBar.currentIndex,
            onTap: (index) {
              navigationBar.goBranch(index);
            },
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: Colors.blueAccent,
            unselectedItemColor: Theme.of(context).colorScheme.outline,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.check_rounded),
                // activeIcon: Icon(Icons.check_rounded),
                label: 'Tareas'
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.checklist_rtl_rounded),
                // activeIcon: Icon(Icons.check_rounded),
                label: 'Tareas terminadas'
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.settings_rounded),
                // activeIcon: Icon(Icons.check_rounded),
                label: 'Configuración'
              ),
            ],
          ),
        ),
      ),


    );
  }
}