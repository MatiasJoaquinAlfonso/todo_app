import 'package:flutter/material.dart';
import 'package:todo_app/features/shared/widgets/widgets.dart';

class HomePage extends StatelessWidget {

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    
    final listTask = [

      (
        title: 'Tarea 1',
        subTitle: 'Incididunt do adipisicing labore mollit laborum sunt eiusmod ad sit pariatur fugiat pariatur adipisicing ex.',
        description: 'Duis mollit deserunt velit adipisicing. Veniam sint veniam mollit do non eu do aute ut amet esse. Proident et do sint nulla irure dolor excepteur laborum deserunt anim eiusmod aliqua tempor. Ea aliqua laborum duis ad aliquip voluptate quis. Et sint Lorem officia irure deserunt labore esse occaecat ut nulla irure fugiat. Culpa sint excepteur sit commodo ea do pariatur. Nostrud et magna ipsum voluptate consequat ullamco eu culpa excepteur culpa elit.',
      ),

      (
        title: 'Tarea 2',
        subTitle: 'Incididunt do adipisicing labore mollit laborum sunt eiusmod ad sit pariatur fugiat pariatur adipisicing ex.',
        description: 'Duis mollit deserunt velit adipisicing. Veniam sint veniam mollit do non eu do aute ut amet esse. Proident et do sint nulla irure dolor excepteur laborum deserunt anim eiusmod aliqua tempor. ',
      ),

      (
        title: 'Tarea 3',
        subTitle: 'Incididunt do adipisicing labore mollit laborum sunt eiusmod ad sit pariatur fugiat pariatur adipisicing ex.',
        description: 'Duis mollit deserunt velit adipisicing. Veniam sint veniam mollit do non eu do aute ut amet esse. Proident et do sint nulla irure dolor excepteur laborum deserunt anim eiusmod aliqua tempor. Ea aliqua laborum duis ad aliquip voluptate quis. Et sint Lorem officia irure deserunt labore esse occaecat ut nulla irure fugiat. Culpa sint excepteur sit commodo ea do pariatur. Nostrud et magna ipsum voluptate consequat ullamco eu culpa excepteur culpa elit.',
      ),

    ];



    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('TO-DO APP'),
        // backgroundColor: Colors.blue.shade600,
        actionsPadding: EdgeInsets.symmetric(horizontal: 10),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.dark_mode_outlined),
          )
        ],
      ),
      // Despues agregar la propiedad .Builder para hacer una lista infinita
      body: listTask.isEmpty 
        ? const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Icon(
                Icons.check_rounded,
                size: 60,
                // color: ,
              ),
              SizedBox(height: 16,),
              Text(
                'No hay tareas para mostrar.',
                style: TextStyle(fontSize: 18, ),
              ),
            ],
          ),
        )
        : ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        itemCount: listTask.length + 1,
        itemBuilder: (context, index) {

          if (index == listTask.length) return ButtonNewTask();
          
          final task = listTask[index];
          return TaskCard(
            title: task.title, 
            subTitle: task.subTitle,
            longDescription: task.description, 
            borderRadius: 15,
          );
        },

      ),

    );
  }
}