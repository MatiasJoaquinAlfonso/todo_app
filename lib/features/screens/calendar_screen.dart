import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/features/todo/presentation/bloc/todo_bloc.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Text(
                'Calendario',
                style: GoogleFonts.manrope(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: cs.onSurface,
                  letterSpacing: -1,
                ),
              ),
            ),

            // Dates Row (Mock)
            SizedBox(
              height: 90,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                scrollDirection: Axis.horizontal,
                itemCount: 14,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final date = DateTime.now().add(Duration(days: index - 2));
                  final isSelected =
                      date.day == _selectedDate.day &&
                      date.month == _selectedDate.month;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDate = date;
                      });
                    },
                    child: Container(
                      width: 64,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? cs.primary
                            : (isDark
                                  ? cs.surfaceContainerLow
                                  : cs.surfaceContainerHighest),
                        borderRadius: BorderRadius.circular(24),
                        border: isSelected
                            ? null
                            : Border.all(
                                color: cs.outlineVariant.withAlpha(
                                  isDark ? 30 : 50,
                                ),
                              ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _getWeekdayShort(date.weekday),
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? cs.onPrimary
                                  : cs.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${date.day}',
                            style: GoogleFonts.manrope(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? cs.onPrimary : cs.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // Timeline
            Expanded(
              child: BlocBuilder<TodoBloc, TodoState>(
                builder: (context, state) {
                  if (state is TodoLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TodoLoaded) {
                    final events = state.events.where((e) {
                      return e.dateInit.year == _selectedDate.year &&
                          e.dateInit.month == _selectedDate.month &&
                          e.dateInit.day == _selectedDate.day;
                    }).toList();

                    return ListView.builder(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 24,
                        bottom: 100,
                      ),
                      itemCount: events.isEmpty ? 1 : events.length,
                      itemBuilder: (context, index) {
                        if (events.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: Text(
                                'No hay tareas para este día',
                                style: GoogleFonts.inter(
                                  color: cs.onSurfaceVariant,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          );
                        }

                        final event = events[index];
                        final isDone = event.isDone;
                        final hasEndTime =
                            !event.isAllDay &&
                            event.dateInit.compareTo(event.dateFinish) != 0;
                        final taskColor = isDone
                            ? Colors.green
                            : (event.category != null
                                  ? Color(event.category!.color)
                                  : cs.primary);

                        return IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // ── Time Column ──
                              SizedBox(
                                width: 48,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        _formatTime(event.dateInit),
                                        style: GoogleFonts.inter(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: cs.onSurface,
                                        ),
                                      ),
                                      if (hasEndTime) ...[
                                        const SizedBox(height: 4),
                                        Text(
                                          _formatTime(event.dateFinish),
                                          style: GoogleFonts.inter(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                            color: cs.onSurfaceVariant,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),

                              // ── Timeline Divider ──
                              SizedBox(
                                width: 24,
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    // Vertical line (hides on the last item if preferred, but it's okay, we can draw it always or until bottom)
                                    if (index != events.length - 1)
                                      Container(
                                        width: 2,
                                        color: cs.outlineVariant.withAlpha(
                                          isDark ? 30 : 50,
                                        ),
                                        margin: const EdgeInsets.only(top: 32),
                                      ),
                                    // Timeline Dot
                                    Positioned(
                                      top: 24,
                                      child: Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: isDark
                                              ? cs.surface
                                              : Colors.white,
                                          border: Border.all(
                                            color: taskColor,
                                            width: 3,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // ── Task Card ──
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 24),
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: isDark
                                          ? cs.surfaceContainerLow
                                          : cs.surfaceContainerHighest,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: cs.outlineVariant.withAlpha(
                                          isDark ? 30 : 50,
                                        ),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(
                                            alpha: isDark ? 0.2 : 0.02,
                                          ),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          event.title,
                                          style: GoogleFonts.inter(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: cs.onSurface,
                                            decoration: isDone
                                                ? TextDecoration.lineThrough
                                                : null,
                                          ),
                                        ),
                                        if (event.description != null &&
                                            event.description!.isNotEmpty) ...[
                                          const SizedBox(height: 6),
                                          Text(
                                            event.description!,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.inter(
                                              fontSize: 13,
                                              color: cs.onSurfaceVariant,
                                              decoration: isDone
                                                  ? TextDecoration.lineThrough
                                                  : null,
                                            ),
                                          ),
                                        ],
                                        // Optional: Category Tag and Google Sync Indicator
                                        if (event.category != null || event.isSynced) ...[
                                          const SizedBox(height: 12),
                                          Wrap(
                                            spacing: 8,
                                            runSpacing: 8,
                                            children: [
                                              if (event.category != null)
                                                Container(
                                                  padding: const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Color(
                                                      event.category!.color,
                                                    ).withAlpha(30),
                                                    borderRadius:
                                                        BorderRadius.circular(8),
                                                  ),
                                                  child: Text(
                                                    event.category!.title,
                                                    style: GoogleFonts.inter(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w600,
                                                      color: Color(
                                                        event.category!.color,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              if (event.isSynced)
                                                Container(
                                                  padding: const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: cs.primary.withAlpha(30),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Icon(Icons.sync_rounded, size: 10, color: cs.primary),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                        'G-Sync',
                                                        style: GoogleFonts.inter(
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.w600,
                                                          color: cs.primary,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
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

  String _getWeekdayShort(int weekday) {
    switch (weekday) {
      case 1:
        return 'Lun';
      case 2:
        return 'Mar';
      case 3:
        return 'Mié';
      case 4:
        return 'Jue';
      case 5:
        return 'Vie';
      case 6:
        return 'Sáb';
      case 7:
        return 'Dom';
      default:
        return '';
    }
  }

  String _formatTime(DateTime date) {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
