import 'package:flutter/material.dart';

class CategoryTile extends StatefulWidget {
  final Function(String title, int colo, int priority) onCreate;
  final Color textColor;
  final Color hintColor;
  // final Color backgroundColor;

  const CategoryTile({
    super.key,
    required this.onCreate,
    required this.textColor,
    required this.hintColor,
    // required this.backgroundColor,
  });

  @override
  State<CategoryTile> createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  bool _isEditing = false;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  int _priority = 0;
  int _selectedColor = 0xFF2196F3;
  // int _selectedColor = 0xFF000000;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && _isEditing) {
        _sumbit();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _sumbit() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onCreate(text, _selectedColor, _priority);
    }

    _controller.clear();
    setState(() {
      _isEditing = false;
      _priority = 0;
    });
  }

  void _togglePriority() {
    setState(() {
      _priority = (_priority + 1) % 4;
    });
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _isEditing
        ? Color(_selectedColor)
        : Colors.transparent;

    // final backgroundColor = widget.backgroundColor;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),

      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (!_isEditing) {
      return ListTile(
        leading: const Icon(Icons.add, color: Colors.grey),
        title: Text(
          'Nueva Categoria',
          style: TextStyle(
            color: widget.textColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        // subtitle: Text(
        //   'Prioridad',
        //   style: TextStyle(
        //     color: Colors.grey[600],
        //     fontSize: 13,
        //     fontWeight: FontWeight.w400,
        //   ),
        // ),
        onTap: () {
          setState(() {
            _isEditing = true;
          });

          WidgetsBinding.instance.addPostFrameCallback((_) {
            _focusNode.requestFocus();
          });
        },
      );
    }

    return ListTile(
      leading: GestureDetector(
        onTap: () {
          // TODO: Picker color.
        },
        // child: CircleAvatar(
        //   backgroundColor: Color(_selectedColor),
        //   radius: 12,
        // ),
      ),
      title: TextField(
        controller: _controller,
        focusNode: _focusNode,
        decoration: const InputDecoration(
          hintText: 'Nombre de la lista',
          border: InputBorder.none,
          isDense: true,
        ),
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: widget.textColor,
        ),

        onSubmitted: (_) => _sumbit(),
      ),
      subtitle: TextField(
        controller: _controller,
        focusNode: _focusNode,
        decoration: const InputDecoration(
          hintText: 'Prioridad',
          border: InputBorder.none,
          isDense: true,
        ),
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: widget.hintColor,
        ),

        onSubmitted: (_) => _sumbit(),
      ),

      trailing: IconButton(
        icon: Icon(Icons.flag_rounded, size: 20, color: Colors.redAccent),
        tooltip: 'Cambiar prioridad',
        onPressed: _togglePriority,
      ),

      // trailing: IconButton(
      //   icon: Icon(Icons.close, size: 20, color: Colors.grey),
      //   onPressed: () {
      //     _controller.clear();
      //     setState(() {
      //       _isEditing = false;
      //     });
      //   },
      // ),
    );
  }
}
