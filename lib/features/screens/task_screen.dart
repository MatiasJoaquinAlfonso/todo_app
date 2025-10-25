import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TaskScreen extends StatelessWidget {

  const TaskScreen({super.key});

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
          'Tarea',
          style: TextStyle(

          ),

        ),
      ),
    );
  }
}