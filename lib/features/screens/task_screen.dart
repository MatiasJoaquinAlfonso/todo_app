import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TaskScreen extends StatefulWidget {

  final String? taskId;

  const TaskScreen({
    super.key, 
    this.taskId
  });

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {

  final _titleController =  TextEditingController();
  final _descriptionController = TextEditingController();

  // bool get _isEditing => widget.taskId != null;

  // @override
  // void initState() {
    
  //   if (_isEditing ) {
  //     // TODO: cargar los datos desde el estado

  //     _titleController.text = 'Tarea cargada ${widget.taskId}'; 
  //     _descriptionController.text = 'Descripcion';
  //   } else {
  //     _titleController.addListener(_updateAppbarTitle);
  //   }

  //   super.initState();
  // }

  // void _updateAppbarTitle() {
  //   setState(() {
      
  //   });
  // }


  // @override
  // void dispose() {


  //   _titleController.removeListener(_updateAppbarTitle);
  //   _titleController.dispose();
  //   _descriptionController.dispose();
  //   super.dispose();
  // }

  // void saveTask() {
  //   // final title = _titleController.text;
  //   // final description = _descriptionController.text;

  //   if (_isEditing) {
  //     // TODO: Guardar los cambios de la tarea.
  //   } else {
  //     // TODO: Guardar la nueva tarea.
  //   }

  //   if (context.canPop()){
  //     context.pop();
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          }, 
          icon: Icon(Icons.keyboard_arrow_left_rounded),
        ),
        title: Text(
          _titleController.text.isEmpty 
            ? 'Nueva tarea'
            : _titleController.text,
          style: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {
              
            },
            icon: Icon(Icons.save_alt_rounded),
          )
        ],
      ),

      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Expanded(
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

      // body: Padding(
      //   padding: EdgeInsets.all(16),
      //   child: Column(
      //     children: [
      //       TextFormField(
      //         controller: _descriptionController,
      //         decoration: InputDecoration(
      //           labelText: 'Descripción',
      //           border: OutlineInputBorder(), 
      //           alignLabelWithHint: true,
      //         ),
      //         maxLines: null,
      //         keyboardType: TextInputType.multiline,
      //         expands: true,
      //         textAlignVertical: TextAlignVertical.top,
      //       ),
      //     ],
      //   ), 
      // ),

    );
  }
}