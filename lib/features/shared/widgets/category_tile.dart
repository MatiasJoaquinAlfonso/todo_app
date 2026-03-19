import 'package:flutter/material.dart';

import 'package:todo_app/features/todo/domain/entities/category_entity.dart';

class CategoryTile extends StatefulWidget {
  final CategoryEntity? category;
  final Function(String title, int color, int priority) onSave;
  final VoidCallback? onDelete;

  const CategoryTile({
    super.key,
    this.category,
    required this.onSave,
    this.onDelete,
  });

  @override
  State<CategoryTile> createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  bool get _isNewCategory => widget.category == null;
  final FocusNode _focusNode = FocusNode();

  late int _priority;
  late TextEditingController _controller;
  late int _selectedColor = 0xFF2196F3;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.category?.title ?? 'Nueva categoria',
    );
    _selectedColor = widget.category?.color ?? _selectedColor;
    _priority = widget.category?.priority ?? 0;

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _trySave();
      }
    });
  }

  void _trySave() {
    final tituloActual = _controller.text.trim();
    final esVacioODefecto = tituloActual.isEmpty || tituloActual == 'Nueva categoria' || tituloActual == 'Nueva categoría....' || tituloActual == 'Nuevacategoria';

    if (esVacioODefecto) {
      if (_isNewCategory) {
        _controller.text = '';
      } else {
        _controller.text = widget.category!.title;
        setState(() {
          _priority = widget.category?.priority ?? 0;
          _selectedColor = widget.category?.color ?? 0xFF2196F3;
        });
      }
      return;
    }

    widget.onSave(_controller.text.trim(), _selectedColor, _priority);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  String get _priorityText {
    switch (_priority) {
      case 1:
        return 'Baja';
      case 2:
        return 'Media';
      case 3:
        return 'Alta';
      default:
        return 'Sin prioridad';
    }
  }

  Color get _priorityColor {
    switch (_priority) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _togglePriority() {
    setState(() => _priority = (_priority + 1) % 4);
    _trySave();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;

    final backgroundColor  = isLight
      ? HSLColor.fromColor(Color(_selectedColor)).withLightness(0.45).toColor()
      : HSLColor.fromColor(Color(_selectedColor)).withLightness(0.25).toColor();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TapRegion(
        onTapOutside: (_) => _focusNode.unfocus(),
        child: _isNewCategory 
          ? Container(
            padding: EdgeInsetsGeometry.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: backgroundColor,

              border: _isNewCategory 
                ? Border.all(color: theme.hintColor.withAlpha(50), width: 2) 
                : null,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        style: TextStyle(
                          // color: theme.colorScheme.onSurface,
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.none,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Nueva categoría....',
                          hintStyle: TextStyle(color: Colors.transparent),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
      
                      const SizedBox(height: 6),
      
                      GestureDetector(
                        onTap: _togglePriority,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: theme.cardColor.withAlpha(200),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.flag, size: 14, color: _priorityColor),
                              const SizedBox(width: 6),
                              Text(
                                _priorityText,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
      
      
                    ],
                  ),
                ),
      
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context, 
                      builder: (context) {
                        return _SimpleColorPicker(
                          initialColor: Color(_selectedColor),
                          onSelectedColor: (Color nuevoColor) {
                            setState(() {
                              _selectedColor = nuevoColor.toARGB32();
                            });
                            _trySave();
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(_selectedColor),
                      border: Border.all(color: Colors.white60, width: 2),
                    ),
                  ),
                )
      
              ],
            ),
          )
      
          : ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Dismissible(
                key: ValueKey(widget.category!.id), 
                direction: DismissDirection.startToEnd,
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        const Color.fromARGB(37, 244, 67, 54),
                        Colors.redAccent.shade700,
                      ],
                      stops: const [0.4, 1.0],
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white,),
                ),
                confirmDismiss: (direction) async {
                  if (widget.onDelete != null) {
                    widget.onDelete!();
                  }
                  return false;
                },
                  
                child: Container(
                    padding: EdgeInsetsGeometry.all(8),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      border: _isNewCategory 
                        ? Border.all(color: theme.hintColor.withAlpha(50), width: 2) 
                        : null,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                controller: _controller,
                                focusNode: _focusNode,
                                style: TextStyle(
                                  // color: theme.colorScheme.onSurface,
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.none,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Nueva categoría....',
                                  hintStyle: TextStyle(color: Colors.transparent),
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                              ),
                  
                              const SizedBox(height: 6),
                  
                              GestureDetector(
                                onTap: _togglePriority,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: theme.cardColor.withAlpha(200),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.flag, size: 14, color: _priorityColor),
                                      const SizedBox(width: 6),
                                      Text(
                                        _priorityText,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                  
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context, 
                              builder: (context) {
                                return _SimpleColorPicker(
                                  initialColor: Color(_selectedColor),
                                  onSelectedColor: (Color nuevoColor) {
                                    setState(() {
                                      _selectedColor = nuevoColor.toARGB32();
                                    });
                                    _trySave();
                                  },
                                );
                              },
                            );
                          },
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(_selectedColor),
                              border: Border.all(color: Colors.white60, width: 2),
                            ),
                          ),
                        )
                      ],
                    ),
                ),
              ),
          ),
      ),
    );
  }
}


class _SimpleColorPicker extends StatefulWidget {

  final Color initialColor;
  final Function(Color) onSelectedColor;


  const _SimpleColorPicker({
    required this.initialColor,
    required this.onSelectedColor, 
  });

  @override
  State<_SimpleColorPicker> createState() => _SimpleColorPickerState();
}

class _SimpleColorPickerState extends State<_SimpleColorPicker> {
  
  late Color _colorElegido;

  final List<Color> _palette = [
    Colors.blue, Colors.lightBlue, Colors.cyan, Colors.teal,
    Colors.green, Colors.lightGreen, Colors.lime, Colors.yellow,
    Colors.amber, Colors.orange, Colors.deepOrange, Colors.red,
    Colors.pink, Colors.purple, Colors.deepPurple, Colors.indigo,
    Colors.blueGrey, Colors.brown, Colors.grey, Colors.black87,
  ];

  @override
  void initState() {
    super.initState();
    _colorElegido = widget.initialColor;
  }

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: const Text('Elegí un color'),
      content: SingleChildScrollView(
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: _palette.map((color) {
            final isSelected = _colorElegido == color;
            
            return GestureDetector(
              onTap: () {
                setState(() {
                  _colorElegido = color;
                });
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: isSelected 
                      ? Border.all(color: Colors.white, width: 3)
                      : Border.all(color: Colors.black12, width: 1),
                  boxShadow: isSelected ? [
                    BoxShadow(color: color.withAlpha(100), blurRadius: 8, spreadRadius: 2)
                  ] : null,
                ),
                child: isSelected 
                    ? const Icon(Icons.check, color: Colors.white, size: 20)
                    : null,
              ),
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed:() {
            Navigator.pop(context);
          },
          child: const Text('Cancelar', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        TextButton(
          onPressed:() {
            widget.onSelectedColor(_colorElegido);
            Navigator.pop(context);
          },
          child: const Text('Aceptar', style: TextStyle(fontWeight: FontWeight.bold)),
        )
      ],
    );
  }
}