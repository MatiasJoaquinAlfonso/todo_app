import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/features/shared/services/notification_service.dart';
import 'package:todo_app/features/todo/domain/entities/event_entity.dart';
import 'package:todo_app/features/todo/presentation/bloc/bloc/todo_bloc.dart';
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
  DateTime _dateFinish = DateTime.now();
  TimeOfDay _timeInit = TimeOfDay.now();
  TimeOfDay _timeFinish = TimeOfDay.now();
  bool get _isEditing => widget.event != null;
  bool _shouldSave = true;
  bool _allowPop = false;
  bool _isAllDay = false;

  @override
  void initState() {
    super.initState();

    if (_isEditing) {
      _titleController.text = widget.event!.title;
      _descriptionController.text = widget.event!.description ?? '';
      _dateInit = widget.event!.dateInit;
      _dateFinish = widget.event!.dateFinish;
      _isAllDay = widget.event!.isAllDay;
      _timeInit = TimeOfDay.fromDateTime(widget.event!.dateInit);
      _timeFinish = TimeOfDay.fromDateTime(widget.event!.dateFinish);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDateRange() async {
    final now = DateTime.now();

    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(2100),
      initialDateRange: DateTimeRange(
        start: _dateInit,
        end: _dateFinish.isBefore(_dateInit) ? _dateInit : _dateFinish,
      ),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.blue,
              onPrimary: Colors.white,
              surface: Colors.grey.shade900,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _dateInit = picked.start;
        _dateFinish = picked.end;
      });
    }
  }


  Future<void> _pickTime ({required bool isStart}) async {
    final picked = await showTimePicker(
      context: context, 
      initialTime: isStart ? _timeInit : _timeFinish,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.blue,
              onPrimary: Colors.white,
              surface: Colors.grey.shade900,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null){
      setState(() {
        if(isStart){
          _timeInit = picked;
        } else {
          _timeFinish = picked;
        }

      });
    }
  }

  DateTime _joinDateTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  bool _saveTask() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    DateTime finalDateInit;
    DateTime finalDateFinish;

    if (!_shouldSave) return true;

    if (_isAllDay) {
      finalDateInit = DateTime(_dateInit.year, _dateInit.month, _dateInit.day, 0, 0);
      finalDateFinish = DateTime(_dateFinish.year, _dateFinish.month, _dateFinish.day, 23, 59);
    } else {
      finalDateInit = _joinDateTime(_dateInit, _timeInit);
      finalDateFinish = _joinDateTime(_dateFinish, _timeFinish);
    }    

    if (finalDateFinish.isBefore(finalDateInit)){
      DialogUtils.show(
        context: context,
        title: "Fecha inválida", 
        message: "El horario de fin no puede ser anterior al horario de inicio.",
        cancelText: "Seguir editando",
        confirmText: "Descartar",
        isError: true,
      );
      return false;
    }

    if (_isEditing) {
      final updatedTask = widget.event!.copyWith(
        title: title,
        description: description,
        dateInit: finalDateInit,
        dateFinish: finalDateFinish,
        isAllDay: _isAllDay,
      );
      context.read<TodoBloc>().add(TodoUpdated(updatedTask));
    } else {
      final newTask = EventEntity(
        title: title,
        description: description,
        dateInit: finalDateInit,
        dateFinish: finalDateFinish,
        isAllDay: _isAllDay,
        isDone: false,
      );
      context.read<TodoBloc>().add(TodoAdded(newTask));
    }

    _scheduleNotification(title, description, finalDateInit, finalDateFinish);

    return true;
  }


  Future<void> _scheduleNotification (String title, String description, DateTime dateInit, DateTime dateFinish) async {

    final difference = dateFinish.difference(dateInit).inDays;

    final daysToSchedule = difference == 0 ? 1 : difference + 1;

    for (int i = 0; i < daysToSchedule; i++){

        DateTime alertDate = dateInit.add(Duration(days: i));

      if(_isAllDay){
        alertDate = DateTime(alertDate.year, alertDate.month, alertDate.day, 9, 0);
      } else {
        alertDate = DateTime (
          alertDate.year,
          alertDate.month,
          alertDate.day,
          _timeInit.hour,
          _timeInit.minute,
        );
      }
      // Creamos un ID temporal.
      final notificationID = DateTime.now().millisecondsSinceEpoch % 100000;
      await NotificationService().scheduleNotification(
        id: notificationID,
        title: "Recordatorio: $title",
        body: description.isNotEmpty ? description : "¡Es hora de tu tarea!",
        scheduledDate: alertDate,
      );

    }

  }


  void _deleteTask() {
    _shouldSave = false;
    if (widget.event != null) {
      context.read<TodoBloc>().add(TodoDeleted(widget.event!));
    }

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _allowPop,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        final description = _descriptionController.text.trim();
        final title = _titleController.text.trim();

        if (title.isEmpty && description.isEmpty){
          context.pop();
          return;
        }

        if (title.isEmpty && description.isNotEmpty){
          DialogUtils.show(
            context: context,
            title: "¿Descartar cambios?", 
            message: "La tarea no tiene título y no se guardará.",
            cancelText: "Seguir editando",
            confirmText: "Descartar",
            isError: true,
            onConfirm: () {
              setState(() => _allowPop = true);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if(context.mounted) context.pop();
              });

            },
          );
          return;
        }

        // 4. Intentar guardar
        final guardadoExitoso = _saveTask();
        if (guardadoExitoso) {
          setState(() => _allowPop = true);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) Navigator.of(context).pop();
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).maybePop();
            },
            icon: const Icon(Icons.keyboard_arrow_left_rounded),
          ),
          title: TextFormField(
            controller: _titleController,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 23),
            decoration: const InputDecoration(
              hintText: 'Nueva tarea',
              border: InputBorder.none,
            ),
            textCapitalization: TextCapitalization.sentences,
          ),
          actions: [
            if (_isEditing)
              IconButton(
                onPressed: () => _deleteTask(),
                icon: Icon(Icons.delete_outline, color: Colors.red.shade600),
              ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    children: [
                      DateTimeSelector(
                        icon: Icons.calendar_today_rounded,
                        label1: "Inicio", 
                        value1: "${_dateInit.day}/${_dateInit.month}/${_dateInit.year}", 
                        onTap1: () => _pickDateRange(),
                        label2: "Fin", 
                        value2: "${_dateFinish.day}/${_dateFinish.month}/${_dateFinish.year}",
                        onTap2: () => _pickDateRange(),
          
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Todo el día?", style: TextStyle(fontSize: 13, color: Colors.grey[400])),
          
                            SizedBox(height: 6),
          
                            SizedBox(
                              height: 24,
                              child: Transform.scale(
                                scale: 0.9,
                                child: Switch(
                                  value: _isAllDay,
                                  activeThumbColor: Colors.blueAccent,
                                  inactiveThumbColor: Colors.blueAccent,
                                  trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
                                  onChanged: (val) => setState(() => _isAllDay =val ), 
                                ),
                              ),
                            )
                          ],
                        ),
          
                      ),
          
                      const SizedBox(height: 12),
          
                      if (_isAllDay == false)
                      DateTimeSelector(
                        icon: Icons.access_time_rounded, 
                        label1: "Hora inicio", 
                        value1: _timeInit.format(context), 
                        onTap1: () => _pickTime(isStart: true),
                        label2: "Hora fin", 
                        value2: _timeFinish.format(context),
                        onTap2: () => _pickTime(isStart: false),
                        trailing: null,
                      ),
                      
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),

              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      hintText: 'Descripción',
                      border: InputBorder.none,
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
