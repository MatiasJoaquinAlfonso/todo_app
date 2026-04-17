import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/features/todo/domain/entities/category_entity.dart';
import 'package:todo_app/features/todo/presentation/bloc/categories_bloc/bloc/category_bloc.dart';

import '../shared/widgets/widgets.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryBloc, CategoryState>(
      listener: (context, state) {
        if (state is CategoryDeletionConfirmationRequired) {
          DialogUtils.show(
            context: context,
            title: 'Eliminar categoría',
            message:
                'Esta categoría tiene ${state.categoriesCount} tarea(s) asociadas.',
            cancelText: 'Cancelar',
            onCancel: () =>
                context.read<CategoryBloc>().add(CancelDeleteCategory()),
            otherActionText: 'Solo categoría',
            onOtherAction: () => context.read<CategoryBloc>().add(
                  ConfirmDeleteCategory(
                      deleteTasks: false, category: state.category),
                ),
            isError: true,
            confirmText: 'Borrar todo',
            onConfirm: () => context.read<CategoryBloc>().add(
                  ConfirmDeleteCategory(
                      deleteTasks: true, category: state.category),
                ),
          );
        } else if (state is CategoryOperationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Se eliminaron ${state.deletedCount} tarea(s) correctamente.'),
            ),
          );
        }
      },
      buildWhen: (prev, curr) =>
          curr is CategoryLoaded || curr is CategoryLoading,
      builder: (context, state) {
        final cs = Theme.of(context).colorScheme;

        return Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ──────────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 20, 8),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_rounded),
                        onPressed: () => context.pop(),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Organización',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: cs.onSurfaceVariant,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Categorías',
                            style: GoogleFonts.manrope(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: cs.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // ── Body ────────────────────────────────────────────────────
                Expanded(
                  child: Builder(
                    builder: (context) {
                      if (state is CategoryLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is CategoryLoaded) {
                        if (state.categories.isEmpty) {
                          return _EmptyCategories(
                            onAdd: () => _showAddCategory(context),
                          );
                        }

                        return ListView.builder(
                          padding:
                              const EdgeInsets.fromLTRB(16, 4, 16, 100),
                          itemCount: state.categories.length + 1,
                          itemBuilder: (context, index) {
                            if (index == state.categories.length) {
                              // ── "New category" tile ──────────────────────
                              return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: CategoryTile(
                                  key: const ValueKey('new_category'),
                                  category: null,
                                  onSave: (title, color, priority) {
                                    final entity = CategoryEntity(
                                      title: title,
                                      color: color,
                                      priority: priority,
                                    );
                                    context
                                        .read<CategoryBloc>()
                                        .add(CreateCategory(entity));
                                  },
                                ),
                              );
                            }

                            final cat = state.categories[index];
                            return CategoryTile(
                              key: ValueKey(cat.id),
                              category: cat,
                              onSave: (title, color, priority) {
                                final updated = CategoryEntity(
                                  id: cat.id,
                                  title: title,
                                  color: color,
                                  priority: priority,
                                );
                                context
                                    .read<CategoryBloc>()
                                    .add(UpdateCategory(updated));
                              },
                              onDelete: () => context
                                  .read<CategoryBloc>()
                                  .add(RequestDeleteCategory(cat)),
                            );
                          },
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAddCategory(BuildContext context) {
    // Scroll to new-category tile — handled by the list itself
    // (It is always visible as the last item even when the list is empty)
  }
}

// ─── Empty state ─────────────────────────────────────────────────────────────
class _EmptyCategories extends StatelessWidget {
  final VoidCallback onAdd;
  const _EmptyCategories({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    color: cs.tertiaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.label_outline_rounded,
                    size: 44,
                    color: cs.onTertiaryContainer,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Sin categorías aún',
                  style: GoogleFonts.manrope(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Crea tu primera categoría\nen el formulario de abajo.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: cs.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Show new-category form even on empty state
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          child: CategoryTile(
            key: const ValueKey('new_category_empty'),
            category: null,
            onSave: (title, color, priority) {
              final entity = CategoryEntity(
                title: title,
                color: color,
                priority: priority,
              );
              context.read<CategoryBloc>().add(CreateCategory(entity));
            },
          ),
        ),
      ],
    );
  }
}
