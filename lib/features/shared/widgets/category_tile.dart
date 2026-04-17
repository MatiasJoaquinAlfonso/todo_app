import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/features/todo/domain/entities/category_entity.dart';

/// Stitch-compliant category tile — No-Line, tonal depth.
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
  bool get _isNew => widget.category == null;
  final FocusNode _focusNode = FocusNode();

  late int _priority;
  late TextEditingController _controller;
  late int _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.category?.color ?? 0xFF5C6BC0;
    _priority = widget.category?.priority ?? 0;
    _controller = TextEditingController(
      text: widget.category?.title ?? '',
    );
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) _trySave();
    });
  }

  void _trySave() {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      if (!_isNew) {
        _controller.text = widget.category!.title;
        setState(() {
          _priority = widget.category!.priority;
          _selectedColor = widget.category!.color;
        });
      }
      return;
    }
    widget.onSave(text, _selectedColor, _priority);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // ── Priority helpers ──────────────────────────────────────────────────────
  static const _priorityLabels = ['Sin prioridad', 'Baja', 'Media', 'Alta'];
  static const _priorityColors = [
    Color(0xFF9E9E9E),
    Color(0xFF43A047),
    Color(0xFFFB8C00),
    Color(0xFFE53935),
  ];

  void _togglePriority() {
    setState(() => _priority = (_priority + 1) % 4);
    _trySave();
  }

  void _pickColor() {
    showDialog(
      context: context,
      builder: (_) => _SimpleColorPicker(
        initialColor: Color(_selectedColor),
        onSelectedColor: (c) {
          setState(() => _selectedColor = c.toARGB32());
          _trySave();
        },
      ),
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final accent = Color(_selectedColor);
    final hsl = HSLColor.fromColor(accent);
    final tileBg = isDark
        ? hsl.withLightness(0.18).withSaturation(0.35).toColor()
        : hsl.withLightness(0.92).withSaturation(0.35).toColor();
    final stripeColor = isDark
        ? hsl.withLightness(0.55).toColor()
        : hsl.withLightness(0.42).toColor();

    final priorityColor = _priorityColors[_priority];

    Widget tile = Material(
      color: tileBg,
      borderRadius: BorderRadius.circular(16),
      child: TapRegion(
        onTapOutside: (_) => _focusNode.unfocus(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Accent stripe
            Container(
              width: 4,
              height: 68,
              decoration: BoxDecoration(
                color: stripeColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
            ),

            const SizedBox(width: 14),

            // Color dot — tap to pick
            GestureDetector(
              onTap: _pickColor,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: accent,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: accent.withAlpha(80),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(Icons.palette_outlined,
                    size: 16, color: Colors.white.withAlpha(200)),
              ),
            ),

            const SizedBox(width: 12),

            // Title + priority
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    style: GoogleFonts.manrope(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : cs.onSurface,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Nombre de categoría…',
                      hintStyle: GoogleFonts.manrope(
                        fontSize: 15,
                        color: (isDark ? Colors.white : cs.onSurface).withAlpha(80),
                      ),
                      filled: false,
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    onSubmitted: (_) => _trySave(),
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: _togglePriority,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: priorityColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: priorityColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            _priorityLabels[_priority],
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: priorityColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Delete (existing categories only)
            if (!_isNew && widget.onDelete != null)
              IconButton(
                icon: Icon(Icons.delete_outline_rounded,
                    color: cs.error.withAlpha(180), size: 20),
                onPressed: widget.onDelete,
              )
            else
              const SizedBox(width: 8),
          ],
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: tile,
    );
  }
}

// ─── Color Picker Dialog ──────────────────────────────────────────────────────
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
  late Color _picked;

  static const _palette = [
    Color(0xFF5C6BC0), Color(0xFF3F51B5), Color(0xFF1E88E5), Color(0xFF039BE5),
    Color(0xFF00ACC1), Color(0xFF00897B), Color(0xFF43A047), Color(0xFF7CB342),
    Color(0xFFFDD835), Color(0xFFFB8C00), Color(0xFFF4511E), Color(0xFFE53935),
    Color(0xFFD81B60), Color(0xFF8E24AA), Color(0xFF6D4C41), Color(0xFF546E7A),
  ];

  @override
  void initState() {
    super.initState();
    _picked = widget.initialColor;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AlertDialog(
      backgroundColor: isDark ? cs.surfaceContainerHigh : cs.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      title: Text(
        'Elige un color',
        style: GoogleFonts.manrope(fontWeight: FontWeight.w700),
      ),
      content: Wrap(
        spacing: 12,
        runSpacing: 12,
        alignment: WrapAlignment.center,
        children: _palette.map((c) {
          final isSelected = _picked.toARGB32() == c.toARGB32();
          return GestureDetector(
            onTap: () => setState(() => _picked = c),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: c,
                shape: BoxShape.circle,
                boxShadow: isSelected
                    ? [BoxShadow(color: c.withAlpha(120), blurRadius: 10, spreadRadius: 2)]
                    : null,
              ),
              child: isSelected
                  ? const Icon(Icons.check_rounded, color: Colors.white, size: 20)
                  : null,
            ),
          );
        }).toList(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancelar',
              style: GoogleFonts.inter(
                  color: cs.onSurfaceVariant, fontWeight: FontWeight.w500)),
        ),
        FilledButton(
          onPressed: () {
            widget.onSelectedColor(_picked);
            Navigator.pop(context);
          },
          child: Text('Confirmar', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}