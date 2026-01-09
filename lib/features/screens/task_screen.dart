import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/features/todo/domain/entities/event_entity.dart';
import 'package:todo_app/features/todo/presentation/bloc/bloc/todo_bloc.dart';

class TaskScreen extends StatefulWidget {

  final EventEntity? event;

  const TaskScreen({
    super.key, 
    this.event
  });

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {

  final _titleController =  TextEditingController();
  final _descriptionController = TextEditingController();
  bool _shouldSave = true;

  bool get _isEditing => widget.event != null;

  @override
  void initState() {
    super.initState();
    
    if (_isEditing ) {
      _titleController.text = widget.event!.title; 
      _descriptionController.text = widget.event!.description ?? '';
    }

  }

  @override
  void dispose() {

    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }


  void _saveTask() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if(!_shouldSave) return;

    if (title.isEmpty && !_isEditing ){
      return;
    }

    if (title.isEmpty && _isEditing ){
      //TODO: Si borran el titulo y estan editando, validar si quiere no guardar o cancelar.
      return;
    }

    //TODO: Completar los campos hardcoded
    if (_isEditing) {
      final updatedTask = widget.event!.copyWith(
        title: title,
        description: description,
      );

      context.read<TodoBloc>().add(TodoUpdated(updatedTask));
    } else {
      final newTask = EventEntity(
        title: title,
        description: description, 
        dateInit: DateTime.now(),
        isAllDay: false
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
        if (didPop){
          _saveTask();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              context.pop();
            }, 
            icon: Icon(Icons.keyboard_arrow_left_rounded),
          ),
          title: TextFormField(
            controller: _titleController,
            style: TextStyle(fontWeight: FontWeight.w900),
            decoration: const InputDecoration(
              hintText: 'Nueva tarea',
              border: InputBorder.none
            ),
      
            textCapitalization: TextCapitalization.sentences,
          ),
      
          actions: [
            if (_isEditing) 
              IconButton(
                onPressed: () => _deleteTask(),
                icon: Icon(Icons.delete_outline, color: Colors.red.shade600,),
              )

          ],
        ),
      
        body: Padding(
          padding: EdgeInsetsGeometry.all(16),
          child: Column(
            children: [
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
            ]
          ),
        ),
      
      ),
    );
  }
}