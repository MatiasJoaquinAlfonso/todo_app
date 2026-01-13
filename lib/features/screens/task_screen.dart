import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/features/todo/domain/entities/event_entity.dart';
import 'package:todo_app/features/todo/presentation/bloc/bloc/todo_bloc.dart';

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
  bool _shouldSave = true;

  bool get _isEditing => widget.event != null;

  @override
  void initState() {
    super.initState();

    if (_isEditing) {
      _titleController.text = widget.event!.title;
      _descriptionController.text = widget.event!.description ?? '';
      _dateInit = widget.event!.dateInit;
      _dateFinish = widget.event!.dateInit;
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
    // final firstDate = widget.event?.dateInit ?? now;

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

  void _saveTask() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (!_shouldSave) return;

    if (title.isEmpty && !_isEditing) {
      return;
    }

    if (title.isEmpty && _isEditing) {
      //TODO: Si borran el titulo y estan editando, validar si quiere no guardar o cancelar.
      return;
    }

    //TODO: Completar los campos hardcoded
    if (_isEditing) {
      final updatedTask = widget.event!.copyWith(
        title: title,
        description: description,
        dateInit: _dateInit,
        dateFinish: _dateFinish,
      );

      context.read<TodoBloc>().add(TodoUpdated(updatedTask));
    } else {
      final newTask = EventEntity(
        title: title,
        description: description,
        dateInit: _dateInit,
        dateFinish: _dateFinish,
        isAllDay: false,
      );

      context.read<TodoBloc>().add(TodoAdded(newTask));
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
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          _saveTask();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.keyboard_arrow_left_rounded),
          ),
          title: TextFormField(
            controller: _titleController,
            style: const TextStyle(fontWeight: FontWeight.w900),
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
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickDateRange,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today_rounded, color: Colors.blueAccent, size: 20),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Inicio", style: TextStyle(fontSize: 12,color: Colors.grey[400])),

                          Text(
                            "${_dateInit.day}/${_dateInit.month}/${_dateInit.year}",
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Fin", style: TextStyle(fontSize: 12, color: Colors.grey[400])),

                          Text(
                            "${_dateFinish.day}/${_dateFinish.month}/${_dateFinish.year}",
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
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
            ],
          ),
        ),
      ),
    );
  }
}
