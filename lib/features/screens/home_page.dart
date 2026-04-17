import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/features/shared/widgets/widgets.dart';
import 'package:todo_app/features/todo/presentation/bloc/todo_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedFilter = 0; // 0: Todas, 1: Trabajo, 2: Personal

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Top Bar ─────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: cs.primaryContainer,
                        child: Icon(Icons.person, size: 16, color: cs.onPrimary),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Azure Precision',
                        style: GoogleFonts.manrope(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: cs.primary,
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.search_rounded, size: 20, color: cs.primary),
                ],
              ),
            ),
            
            // ── Greeting ─────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hola, Alex.',
                    style: GoogleFonts.manrope(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: cs.primary,
                      letterSpacing: -1.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  BlocBuilder<TodoBloc, TodoState>(
                    builder: (context, state) {
                      int length = 0;
                      if (state is TodoLoaded) {
                        length = state.events.length;
                      }
                      return Text(
                        'Tienes $length tareas pendientes hoy.',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: cs.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // ── Search & Filter ───────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: cs.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search_rounded, size: 18, color: cs.onSurfaceVariant),
                    const SizedBox(width: 12),
                    Text(
                      'Buscar tareas...',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _FilterChip(
                    label: 'Todas',
                    isSelected: _selectedFilter == 0,
                    onTap: () => setState(() => _selectedFilter = 0),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Trabajo',
                    isSelected: _selectedFilter == 1,
                    onTap: () => setState(() => _selectedFilter = 1),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Personal',
                    isSelected: _selectedFilter == 2,
                    onTap: () => setState(() => _selectedFilter = 2),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ── Task list ──────────────────────────────────────────────────
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
                      return _EmptyState(onAdd: () => context.push('/task-screen', extra: null));
                    }

                    return CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                            child: Text(
                              'PRIORIDAD ALTA',
                              style: GoogleFonts.manrope(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: cs.onSurfaceVariant,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final task = state.events[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                                child: TaskCard(
                                  title: task.title,
                                  subTitle: task.description ?? '',
                                  dateInit: task.dateInit,
                                  dateFinish: task.dateFinish,
                                  borderRadius: 16,
                                  categoryName: task.category?.title,
                                  taskPriority: task.priority,
                                  categoryColor: task.category != null
                                      ? Color(task.category!.color)
                                      : null,
                                  onTap: () => context.push('/task-screen', extra: task),
                                  dismissKey: task.id.toString(),
                                  background: _swipeBg(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.only(left: 24),
                                    icon: Icons.check_circle_outline_rounded,
                                    color: const Color(0xFF388E3C),
                                  ),
                                  secondaryBackground: _swipeBg(
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.only(right: 24),
                                    icon: Icons.delete_outline_rounded,
                                    color: const Color(0xFFC62828),
                                  ),
                                  onSwipeRight: () async {
                                    final done = task.copyWith(isDone: true);
                                    context.read<TodoBloc>().add(TodoUpdated(done));
                                    ConfettiSnackbar.show(context, '¡Tarea completada! 🎉');
                                    return false;
                                  },
                                  onSwipeLeft: () async {
                                    context.read<TodoBloc>().add(TodoDeleted(task));
                                    return false;
                                  },
                                ),
                              );
                            },
                            childCount: state.events.length,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 32, 20, 120),
                            child: _WeeklyFocusWidget(),
                          ),
                        ),
                      ],
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
        borderRadius: BorderRadius.circular(16),
      ),
      alignment: alignment,
      padding: padding,
      child: Icon(icon, color: Colors.white, size: 28),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? cs.tertiaryContainer : cs.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? Colors.white : cs.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

class _WeeklyFocusWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [cs.primary, cs.primaryContainer, cs.tertiary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'ENFOQUE SEMANAL',
            style: GoogleFonts.manrope(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Colors.white.withAlpha(180),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Optimiza tu flujo\nde trabajo hoy.',
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Empty state ─────────────────────────────────────────────────────────────
class _EmptyState extends StatelessWidget {
  final VoidCallback onAdd;
  const _EmptyState({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: cs.surfaceContainerHigh,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_rounded,
              size: 52,
              color: cs.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Todo listo por ahora',
            style: GoogleFonts.manrope(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Agrega tu primera tarea y empieza\na organizar tu día.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: cs.onSurfaceVariant,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
          ButtonNewTask(onTap: onAdd),
        ],
      ),
    );
  }
}