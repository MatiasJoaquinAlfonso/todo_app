import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/features/todo/presentation/bloc/todo_bloc.dart';

import '../shared/widgets/widgets.dart';

class TaskFinishScreen extends StatelessWidget {
  const TaskFinishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ─────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '¡Gran trabajo!',
                    style: GoogleFonts.manrope(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: cs.onSurface,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Has completado 12 tareas esta semana.',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            
            // ── Stats Cards ────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: isDark ? cs.surfaceContainerLow : cs.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: cs.outlineVariant.withAlpha(isDark ? 30 : 50)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.local_fire_department_rounded, color: Colors.orange.shade400, size: 28),
                          const SizedBox(height: 12),
                          Text(
                            'Streak',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                          Text(
                            '4 Días',
                            style: GoogleFonts.manrope(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: cs.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue.shade400, Colors.blue.shade700],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withAlpha(80),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.star_rounded, color: Colors.white, size: 28),
                          const SizedBox(height: 12),
                          Text(
                            'Total XP',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                          Text(
                            '2450',
                            style: GoogleFonts.manrope(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Completadas',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: cs.onSurface,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ── List ───────────────────────────────────────────────────────
            Expanded(
              child: BlocBuilder<TodoBloc, TodoState>(
                builder: (context, state) {
                  if (state is TodoLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is TodoError) {
                    return Center(
                      child: Text(
                        'Error: ${state.errorMessage}',
                        style: TextStyle(color: cs.error),
                      ),
                    );
                  }

                  if (state is TodoLoaded) {
                    if (state.events.isEmpty) {
                      return _EmptyCompleted();
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 100),
                      itemCount: state.events.length,
                      itemBuilder: (context, index) {
                        final task = state.events[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: TaskCard(
                            title: task.title,
                            subTitle: task.description ?? '',
                            dateInit: task.dateInit,
                            dateFinish: task.dateFinish,
                            borderRadius: 24,
                            categoryName: task.category?.title,
                            categoryPriority: task.category?.priority,
                            categoryColor: task.category != null
                                ? Color(task.category!.color)
                                : null,
                            onTap: () {},
                            dismissKey: 'finish_${task.id}',
                            background: _swipeBg(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 24),
                              icon: Icons.delete_outline_rounded,
                              color: const Color(0xFFC62828),
                            ),
                            secondaryBackground: _swipeBg(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 24),
                              icon: Icons.replay_rounded,
                              color: const Color(0xFF1565C0),
                            ),
                            onSwipeRight: () async {
                              context.read<TodoBloc>().add(TodoDeleted(task));
                              return false;
                            },
                            onSwipeLeft: () async {
                              final restored = task.copyWith(isDone: false);
                              context.read<TodoBloc>().add(TodoUpdated(restored));
                              return false;
                            },
                          ),
                        );
                      },
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _swipeBg({
    required AlignmentGeometry alignment,
    required EdgeInsets padding,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
      ),
      alignment: alignment,
      padding: padding,
      child: Icon(icon, color: Colors.white, size: 28),
    );
  }
}

class _EmptyCompleted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.done_all_rounded,
              size: 48,
              color: cs.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Aún no hay tareas completadas',
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '¡Es hora de empezar a tachar\nesa lista de tareas!',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: cs.onSurfaceVariant,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}