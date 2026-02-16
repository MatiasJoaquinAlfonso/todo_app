import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/todo/presentation/bloc/categories_bloc/bloc/category_bloc.dart';

import '../shared/widgets/widgets.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categorias')),
      body: BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {
          if(state is CategoryDeletionConfirmationRequired){
            DialogUtils.show(
              context: context,
              title: 'Eliminar categoria',
              message: 'Esta categoria tiene ${state.categoriesCount} tareas',
              cancelText: 'Cancelar',
              otherActionText: 'Solo categoria',
              onOtherAction: () {
                context.read<CategoryBloc>().add(
                  ConfirmDeleteCategory(deleteTasks: false, category: state.category)
                );
              },

              isError: true,
              confirmText: 'Borrar todo',
              onConfirm: () {
                context.read<CategoryBloc>().add(
                  ConfirmDeleteCategory(deleteTasks: true, category: state.category)
                );
              },
            );
          } else if (state is CategoryOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Se borraron exitosamente ${state.deletedCount} tareas'))
            );
          }

        },

        buildWhen: (previous, current) {
          return current is CategoryLoaded || current is CategoryLoading;
        },

        builder: (context, state) {
        
          if (state is CategoryLoading) {
            return CircularProgressIndicator();
          }

          if (state is CategoryLoaded){
            if (state.categories.isEmpty){
              return const Center(child: Text('No hay categorías!'),);
            }

            return ListView.builder(
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                final category = state.categories[index];

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(category.color),
                    radius: 12,
                  ),
                  title: Text(category.title),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () {
                      context.read<CategoryBloc>().add(RequestDeleteCategory(category));
                    }, 
                  ),
                );

              },
            );
          }

          return const Placeholder();
        },
      ),
    );
    
  }
}
