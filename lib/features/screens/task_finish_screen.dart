import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/todo/presentation/bloc/todo_bloc.dart';

import '../shared/widgets/widgets.dart';

class TaskFinishScreen extends StatelessWidget {
  const TaskFinishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {

          if (state is TodoLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TodoError) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          }

          if (state is TodoLoaded) {
            if(state.events.isEmpty){
              return SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text("No hay tareas completadas!"),
                    )
                  ],
                ),
              );
            } else {
              return SafeArea(
                child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                itemCount: state.events.length,
                itemBuilder: (context, index) {
                            
                  final task = state.events[index];
                  return TaskCard(
                    title: task.title, 
                    subTitle: task.description ?? '',
                    dateInit: task.dateInit,
                    dateFinish: task.dateFinish,
                    borderRadius: 15,
                    categoryName: task.category?.title,
                    categoryPriority: task.category?.priority,
                    categoryColor: task.category != null ? Color(task.category!.color) : null,
                    onTap: () {}, 
                    dismissKey: 'finish_${task.id}',
                    background: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            const Color.fromARGB(37, 244, 67, 54),
                            Colors.redAccent.shade700,
                          ],
                          stops: const [0.4, 1.0],  
                        ),
                      ),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 25.0),
                      child: const Icon(
                        Icons.delete_outline_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    secondaryBackground: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [
                            const Color.fromARGB(36, 124, 207, 97),
                            Colors.green.shade700,
                          ],
                          stops: const [0.4, 1.0], 
                        ),
                      ),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 25.0),
                      child: const Icon(
                        Icons.restore_from_trash_sharp,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    onSwipeRight: () async {
                      context.read<TodoBloc>().add(TodoDeleted(task));
                      return false;
                    },
                    onSwipeLeft: () async {
                      final completedTask = task.copyWith(isDone: false);
                      context.read<TodoBloc>().add(TodoUpdated(completedTask));
                      return false;
                    },
                  );
                },
                            
                ),
              );
            }
          }


          return Column(children: [
            
            Text('Iniciando... '),
            CircularProgressIndicator(),

          ]);
          
        },
      ),
    );
  }
}