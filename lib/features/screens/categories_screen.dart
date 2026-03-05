import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/shared/services/notification_service.dart';
import 'package:todo_app/features/todo/presentation/bloc/categories_bloc/bloc/category_bloc.dart';

import '../shared/widgets/widgets.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  bool _showButton = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryBloc, CategoryState>(
      listener: (context, state) {
        if (state is CategoryDeletionConfirmationRequired) {
          DialogUtils.show(
            context: context,
            title: 'Eliminar categoria',
            message: 'Esta categoria tiene ${state.categoriesCount} tareas',
            cancelText: 'Cancelar',
            otherActionText: 'Solo categoria',
            onOtherAction: () {
              context.read<CategoryBloc>().add(
                ConfirmDeleteCategory(
                  deleteTasks: false,
                  category: state.category,
                ),
              );
            },
            isError: true,
            confirmText: 'Borrar todo',
            onConfirm: () {
              context.read<CategoryBloc>().add(
                ConfirmDeleteCategory(
                  deleteTasks: true,
                  category: state.category,
                ),
              );
            },
          );
        } else if (state is CategoryOperationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Se borraron exitosamente ${state.deletedCount} tareas',
              ),
            ),
          );
        }
      },

      buildWhen: (previous, current) {
        return current is CategoryLoaded || current is CategoryLoading;
      },

      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text('Categorias')),

          floatingActionButton: (_showButton)
              ? FloatingActionButton(
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    builder: (c) => Container(
                      height: 200,
                      color: Colors.white,
                      child: Center(child: Text("Formulario")),
                    ),
                  ),
                  child: const Icon(Icons.add),
                )
              : null,

          body: Builder(
            builder: (context) {
              if (state is CategoryLoading) {
                return CircularProgressIndicator();
              }

              if (state is CategoryLoaded) {
                if (state.categories.isEmpty) {
                  // TODO: Cambiar esto cuando cree el widget para esto.
                  return Center(
                    child: TextButton.icon(
                      icon: Icon(Icons.add),
                      label: Text ('Crear primer categoría!'),
                      onPressed: () => showModalBottomSheet(
                        context: context,
                        builder: (c) => Container(
                          height: 200,
                          color: Colors.white,
                          child: Center(child: Text("Formulario")),
                        ),
                      ),
                    )
                  );
                }
                return NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    if (notification is ScrollUpdateNotification) {
                      final show = notification.metrics.extentAfter > 10;
                      if (_showButton != show) {
                        setState(() => _showButton = show);
                      }
                    }
                    return false;
                  },

                  child: ListView.builder(
                    itemCount: state.categories.length + 1,
                    itemBuilder: (context, index) {
                      if (index == state.categories.length) {
                        return CategoryTile(
                          category: null, 
                          onSave: (String title, int color, int priority) { 
                            logger.d('Guardando... ');
                          },
                        );

                        // return CategoryTileV2(
                        //   category: null, // Null indica "Nueva Categoría"
                        //   onSave: (title, color, priority) {
                        //     final newCategory = CategoryEntity(
                        //       title: title, 
                        //       color: color, 
                        //       priority: priority,
                        //       // id es null
                        //     );
                        //     context.read<CategoryBloc>().add(CreateCategory(newCategory));
                        //   },
                        //   // No pasamos onDelete porque no se puede borrar lo que no existe
                        // );



                      }

                      final category = state.categories[index];
                      return CategoryTile(
                        category: category, 
                        onSave: (String title, int color, int priority) { 
                          logger.d('Guardando... ');
                        },
                      );

                      
                      // return CategoryTileV2(
                      //   category: category,
                      //   // Se llama automáticamente al perder foco
                      //   onSave: (title, color, priority) {
                      //      final updatedCategory = CategoryEntity(
                      //         id: category.id,
                      //         title: title,
                      //         color: color,
                      //         priority: priority,
                      //      );
                      //      context.read<CategoryBloc>().add(UpdateCategory(updatedCategory));
                      //   },
                      //   // Botón de basura
                      //   onDelete: () {
                      //     context.read<CategoryBloc>().add(RequestDeleteCategory(category));
                      //   },
                      // );



                    },
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        );
      },
    );
  }
}
