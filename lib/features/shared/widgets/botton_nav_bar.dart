import 'dart:ui';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: navigationBar,
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 24.0, left: 24.0, right: 24.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(9999),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
              child: Container(
                height: 64,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: (isDark ? const Color(0xFF1E3A8A) : const Color(0xFFE0E7FF)).withAlpha(80),
                  borderRadius: BorderRadius.circular(9999),
                  border: Border.all(
                    color: Colors.white.withAlpha(isDark ? 20 : 100),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.shade900.withAlpha(isDark ? 50 : 25),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _NavItem(
                      isSelected: navigationBar.currentIndex == 0,
                      icon: Icons.list_alt_rounded,
                      label: 'Tasks',
                      onTap: () => navigationBar.goBranch(0),
                    ),
                    _NavItem(
                      isSelected: navigationBar.currentIndex == 1,
                      icon: Icons.check_circle_outline_rounded,
                      label: 'Done',
                      onTap: () => navigationBar.goBranch(1),
                    ),
                    _AddNavItem(
                      onTap: () => context.push('/task-screen', extra: null),
                    ),
                    _NavItem(
                      isSelected: navigationBar.currentIndex == 2,
                      icon: Icons.calendar_month_rounded,
                      label: 'Schedule',
                      onTap: () => navigationBar.goBranch(2),
                    ),
                    _NavItem(
                      isSelected: navigationBar.currentIndex == 3,
                      icon: Icons.settings_outlined,
                      label: 'Settings',
                      onTap: () => navigationBar.goBranch(3),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final bool isSelected;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _NavItem({
    required this.isSelected,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(9999),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected 
                    ? (isDark ? Colors.blue.withAlpha(80) : Colors.blue.shade100) 
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Icon(
                icon,
                size: 24,
                color: isSelected 
                    ? (isDark ? Colors.blue.shade100 : Colors.blue.shade800)
                    : (isDark ? Colors.blue.shade200.withAlpha(150) : Colors.blue.shade900.withAlpha(150)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddNavItem extends StatelessWidget {
  final VoidCallback onTap;

  const _AddNavItem({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade400, Colors.blue.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.blue.shade500.withAlpha(100),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Center(
            child: Icon(
              Icons.add_rounded,
              size: 28,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}