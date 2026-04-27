import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/features/calendar_sync/presentation/cubit/calendar_sync_cubit.dart';
import 'package:todo_app/features/todo/domain/entities/category_entity.dart';
import 'package:todo_app/features/todo/domain/entities/event_entity.dart';
import 'package:todo_app/features/todo/presentation/bloc/categories_bloc/bloc/category_bloc.dart';
import 'package:todo_app/features/todo/presentation/bloc/todo_bloc.dart';
import '../shared/widgets/widgets.dart';

class TaskScreen extends StatefulWidget {
  final EventEntity? event;

  const TaskScreen({super.key, this.event});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _dateInit = DateTime.now();
  DateTime _dateFinish = DateTime.now().add(const Duration(hours: 1));
  TimeOfDay _timeInit = TimeOfDay.now();
  TimeOfDay _timeFinish = TimeOfDay.now();
  bool get _isEditing => widget.event != null;
  final bool _shouldSave = true;
  bool _isAllDay = false;
  int _priority = 1;
  CategoryEntity? _selectedCategory;
  bool _syncWithGoogle = false;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _titleController.text = widget.event!.title;
      _descriptionController.text = widget.event!.description ?? '';
      _dateInit = widget.event!.dateInit;
      _dateFinish = widget.event!.dateFinish;
      _isAllDay = widget.event!.isAllDay;
      _priority = widget.event!.priority;
      _timeInit = TimeOfDay.fromDateTime(widget.event!.dateInit);
      _timeFinish = TimeOfDay.fromDateTime(widget.event!.dateFinish);
      _selectedCategory = widget.event?.category;
      _syncWithGoogle = widget.event!.isSynced;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // ── Date / Time pickers ──────────────────────────────────────────────────
  Future<void> _pickDateInit() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dateInit,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dateInit = picked;
        if (_dateFinish.isBefore(_dateInit)) {
          _dateFinish = picked;
        }
      });
    }
  }

  Future<void> _pickDateFinish() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dateFinish.isBefore(_dateInit) ? _dateInit : _dateFinish,
      firstDate: _dateInit,
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dateFinish = picked;
      });
    }
  }

  Future<void> _pickTimeInit() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _timeInit,
    );
    if (picked != null) {
      setState(() {
        _timeInit = picked;
      });
    }
  }

  Future<void> _pickTimeFinish() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _timeFinish,
    );
    if (picked != null) {
      setState(() {
        _timeFinish = picked;
      });
    }
  }

  DateTime _joinDateTime(DateTime date, TimeOfDay time) =>
      DateTime(date.year, date.month, date.day, time.hour, time.minute);

  bool _saveTask() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    if (!_shouldSave) return true;

    if (title.isEmpty) {
      DialogUtils.show(
        context: context,
        title: 'Falta el título',
        message: 'Por favor ingresa un título para la tarea.',
        confirmText: 'Ok',
        cancelText: '',
      );
      return false;
    }

    final DateTime finalDateInit;
    final DateTime finalDateFinish;

    if (_isAllDay) {
      finalDateInit = DateTime(_dateInit.year, _dateInit.month, _dateInit.day);
      finalDateFinish = DateTime(_dateFinish.year, _dateFinish.month, _dateFinish.day, 23, 59);
    } else {
      finalDateInit = _joinDateTime(_dateInit, _timeInit);
      finalDateFinish = _joinDateTime(_dateFinish, _timeFinish);
    }

    if (_isEditing) {
      final updated = widget.event!.copyWith(
        title: title,
        description: description,
        dateInit: finalDateInit,
        dateFinish: finalDateFinish,
        isAllDay: _isAllDay,
        priority: _priority,
        category: _selectedCategory,
      );
      context.read<TodoBloc>().add(TodoUpdated(updated));
    } else {
      final newTask = EventEntity(
        title: title,
        description: description,
        dateInit: finalDateInit,
        dateFinish: finalDateFinish,
        isAllDay: _isAllDay,
        isDone: false,
        priority: _priority,
        category: _selectedCategory,
        isSynced: _syncWithGoogle,
      );
      context.read<TodoBloc>().add(TodoAdded(newTask));
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Header row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.close_rounded, color: cs.primary),
                    onPressed: () => context.pop(),
                  ),
                  Text(
                    'Azure Precision',
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: cs.primary,
                    ),
                  ),
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: cs.primaryContainer,
                    child: Icon(Icons.person, size: 18, color: cs.onPrimary),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and subtitle
                    Text(
                      _isEditing ? 'Editar Tarea' : 'Nueva Tarea',
                      style: GoogleFonts.manrope(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: cs.primary,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Define tu próximo paso con precisión\narquitectónica.',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: cs.onSurfaceVariant,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Title input
                    _SectionLabel('Título de la Tarea', cs),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _titleController,
                      style: GoogleFonts.inter(fontSize: 14, color: cs.onSurface),
                      decoration: InputDecoration(
                        hintText: 'Ej: Revisión trimestral de objetivos',
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Description input
                    _SectionLabel('Descripción', cs),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _descriptionController,
                      maxLines: 4,
                      style: GoogleFonts.inter(fontSize: 14, color: cs.onSurface),
                      decoration: InputDecoration(
                        hintText: 'Detalla los puntos clave de esta\nactividad...',
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Categories
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _SectionLabel('Categoría', cs),
                        Row(
                          children: [
                            Icon(Icons.settings, size: 10, color: cs.primary),
                            const SizedBox(width: 4),
                            Text(
                              'GESTIONAR',
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: cs.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    BlocBuilder<CategoryBloc, CategoryState>(
                      builder: (context, state) {
                        if (state is! CategoryLoaded || state.categories.isEmpty) {
                          return Text('Sin categorías', style: GoogleFonts.inter(fontSize: 12, color: cs.onSurfaceVariant));
                        }
                        return Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            ...state.categories.map((cat) {
                              final isSelected = _selectedCategory?.id == cat.id;
                              final chipColor = Color(cat.color);
                              return _CategoryChip(
                                label: cat.title,
                                isSelected: isSelected,
                                color: chipColor,
                                onTap: () => setState(() {
                                  _selectedCategory = isSelected ? null : cat;
                                }),
                              );
                            }),
                            // The + chip
                            _CategoryChip(
                              label: '+',
                              isSelected: false,
                              color: cs.outlineVariant,
                              onTap: () {},
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 24),

                    // Prioridad
                    _SectionLabel('Prioridad', cs),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _CategoryChip(
                          label: 'Baja',
                          isSelected: _priority == 0,
                          color: const Color(0xFF64B5F6),
                          onTap: () => setState(() => _priority = 0)),
                        _CategoryChip(
                          label: 'Normal',
                          isSelected: _priority == 1,
                          color: const Color(0xFF81C784),
                          onTap: () => setState(() => _priority = 1)),
                        _CategoryChip(
                          label: 'Alta',
                          isSelected: _priority == 2,
                          color: const Color(0xFFE57373),
                          onTap: () => setState(() => _priority = 2)),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Date & Time Grid
                    Row(
                      children: [
                        Expanded(
                          child: _DateTimeBentoCard(
                            title: 'INICIO',
                            dateText: '${_dateInit.day.toString().padLeft(2, '0')}/${_dateInit.month.toString().padLeft(2, '0')}/${_dateInit.year}',
                            timeText: _timeInit.format(context),
                            onDateTap: _pickDateInit,
                            onTimeTap: _pickTimeInit,
                            cs: cs,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _DateTimeBentoCard(
                            title: 'FIN',
                            dateText: '${_dateFinish.day.toString().padLeft(2, '0')}/${_dateFinish.month.toString().padLeft(2, '0')}/${_dateFinish.year}',
                            timeText: _timeFinish.format(context),
                            onDateTap: _pickDateFinish,
                            onTimeTap: _pickTimeFinish,
                            cs: cs,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Reminder row
                    _ActionRow(
                      icon: Icons.notifications_active_rounded,
                      label: 'RECORDATORIO',
                      value: '15 min antes',
                      onTap: () {},
                      cs: cs,
                      showCaret: true,
                    ),
                    const SizedBox(height: 16),

                    // Google Calendar Sync
                    BlocBuilder<CalendarSyncCubit, CalendarSyncState>(
                      builder: (context, calendarState) {
                        final isGoogleConnected = calendarState.isConnected;
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: cs.surfaceContainerLow,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today_rounded,
                                size: 20,
                                color: isGoogleConnected ? cs.primary : cs.onSurfaceVariant,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'GOOGLE CALENDAR',
                                      style: GoogleFonts.manrope(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: cs.onSurfaceVariant,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      isGoogleConnected
                                          ? 'Sincronizar evento'
                                          : 'Conectá tu cuenta en Ajustes',
                                      style: GoogleFonts.inter(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: isGoogleConnected
                                            ? cs.primary
                                            : cs.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Switch(
                                value: _syncWithGoogle,
                                activeThumbColor: cs.primary,
                                onChanged: isGoogleConnected
                                    ? (value) {
                                        setState(() {
                                          _syncWithGoogle = value;
                                        });
                                      }
                                    : null,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 32),

                    // Submit Button
                    ButtonNewTask(
                      onTap: () {
                        if (_saveTask()) {
                          context.pop();
                        }
                      },
                    ),
                    
                    // Cancel
                    Center(
                      child: TextButton(
                        onPressed: () => context.pop(),
                        child: Text(
                          'Cancelar',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: cs.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Helpers ─────────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String text;
  final ColorScheme cs;
  const _SectionLabel(this.text, this.cs);

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: GoogleFonts.manrope(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: cs.primary,
        ),
      );
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.isSelected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: label == '+' ? 16 : 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color : cs.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : cs.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;
  final ColorScheme cs;
  final bool showCaret;

  const _ActionRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
    required this.cs,
    this.showCaret = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: cs.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: cs.primary),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.manrope(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: cs.onSurfaceVariant,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: cs.primary,
                    ),
                  ),
                ],
              ),
            ),
            if (showCaret)
              Icon(Icons.chevron_right_rounded, size: 20, color: cs.onSurfaceVariant),
          ],
        ),
      ),
    );
  }
}

class _DateTimeBentoCard extends StatelessWidget {
  final String title;
  final String dateText;
  final String timeText;
  final VoidCallback onDateTap;
  final VoidCallback onTimeTap;
  final ColorScheme cs;

  const _DateTimeBentoCard({
    required this.title,
    required this.dateText,
    required this.timeText,
    required this.onDateTap,
    required this.onTimeTap,
    required this.cs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.calendar_today_rounded, size: 14, color: cs.primary),
              const SizedBox(width: 6),
              Text(
                title,
                style: GoogleFonts.manrope(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: cs.onSurfaceVariant,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: onDateTap,
            child: Text(
              dateText,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: cs.onSurface,
              ),
            ),
          ),
          const SizedBox(height: 4),
          InkWell(
            onTap: onTimeTap,
            child: Text(
              timeText,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: cs.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
