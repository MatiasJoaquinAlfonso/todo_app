import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[ 
                  Icon(Icons.error_outline, size: 60, color: Colors.red.shade400),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${state.errorMessage}',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          if (state is TodoLoaded) {
            if (state.events.isEmpty){
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                  direction: DismissDirection.endToStart,
                  
                  onDismissed: (direction) {
                    context.read<TodoBloc>().add(TodoDeleted(task));
                  },
            
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
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 25.0),
                    child: const Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
            
                  child: TaskCard(
                    title: task.title, 
                    subTitle: task.subTitle ?? '',
                    longDescription: task.description ?? '', 
                    borderRadius: 15,
                    onTap: () => context.push('/task-screen', extra: task),
                  ),
                );
              },
            
            );


          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}