import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
                  return Dismissible(
                    key: Key(task.id.toString()),
                    // direction: DismissDirection.endToStart,
                    
                    // Completado
                    background: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
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
                
                    //Borrado 
                    secondaryBackground: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
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
                
                    confirmDismiss: (direction) async {
                
                      if(direction == DismissDirection.startToEnd) {
                        context.read<TodoBloc>().add(TodoDeleted(task));
                      
                      } else {
                        final completedTask = task.copyWith(isDone: false);
                        
                        context.read<TodoBloc>().add(TodoUpdated(completedTask));

                      }
                
                      return false;
                    },
                            
                    child: TaskCard(
                      title: task.title, 
                      subTitle: task.subTitle ?? '',
                      // longDescription: task.dateInit.toString() + ' - ' + task.dateFinish.toString() ?? '' , 
                      longDescription: 
                        '${task.dateInit.day}/${task.dateInit.month} - ' // Día/Mes
                        '${task.dateInit.hour}:${task.dateInit.minute.toString().padLeft(2, '0')} - ' // Hora inicio
                        '${task.dateFinish.hour}:${task.dateFinish.minute.toString().padLeft(2, '0')}', // Hora fin
                      borderRadius: 15,
                      onTap: () => context.push('/task-screen', extra: task),
                    ),
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