import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/features/shared/services/notification_service.dart';
import 'package:todo_app/features/shared/widgets/widgets.dart';
import 'package:todo_app/features/todo/presentation/bloc/bloc/todo_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
      
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {

          if (state is TodoLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TodoError) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          }

          if (state is TodoLoaded) {
            if (state.events.isEmpty){
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
                    child: ButtonNewTask(
                      paddingH: 8,
                      onTap: () => context.push('/task-screen', extra: null),
                    ),
                  ),
              
                  Icon(Icons.check_rounded, size: 80, color: Colors.white),
                  const SizedBox(height: 16),
                  Text(
                    'No hay tareas para mostrar.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white
                    ),
                  ),
                  
                ],
              );
            }

            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              itemCount: state.events.length + 1,
              itemBuilder: (context, index) {
            
                 if (index == state.events.length) {
                   return Padding(
                     padding: const EdgeInsets.only(top: 8.0, bottom: 20.0),
                     child: ButtonNewTask(
                       paddingH: 0,
                       onTap: () => context.push('/task-screen', extra: null),
                     ),
                   );
                }
            
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
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                          const Color.fromARGB(36, 124, 207, 97),
                          Colors.green.shade700,
                        ],
                        stops: const [0.4, 1.0],
            
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 25.0),
                    child: const Icon(
                      Icons.check_circle_outline_rounded,
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
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          const Color.fromARGB(37, 244, 67, 54),
                          Colors.redAccent.shade700,
                        ],
                        stops: const [0.4, 1.0],
            
                      ),
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 25.0),
                    child: const Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),

                  confirmDismiss: (direction) async {
                    
                    logger.d(task);

                    if(direction == DismissDirection.startToEnd) {
                      final completedTask = task.copyWith(isDone: true);
                      
                      context.read<TodoBloc>().add(TodoUpdated(completedTask));
                      logger.d(task);
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(
                      //     content: Text("¡Tarea completada! 🎉"), 
                      //     duration: Duration(seconds: 1)
                      //   )
                      // );

                    } else {
                      context.read<TodoBloc>().add(TodoDeleted(task));
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
            
            );


          }

          return Column(children: [
            
            Text('Iniciando... '),
            CircularProgressIndicator(),

          ],);
        },
      ),

    );
  }
}