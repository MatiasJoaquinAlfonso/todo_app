import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class ButtonNewTask extends StatelessWidget {

  final VoidCallback onTap;
  final double paddingH;

  const ButtonNewTask({
    super.key, 
    required this.onTap, 
    this.paddingH = 0
  });

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingH, vertical: 8),
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          radius: Radius.circular(15),
          color: Colors.lightBlue,
          strokeWidth: 1.5,
          dashPattern: [6, 4],
          padding: EdgeInsets.zero
        ),
        child: Card(
          color: (isLight ? Color(0xFFFFFFFF) : theme.colorScheme.surfaceContainerLowest),
          clipBehavior: Clip.antiAlias,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          margin: EdgeInsets.zero,
          child: InkWell(
            onTap: onTap,
            child: ListTile(
              title: Text(
                'Agregar nueva tarea',
                textAlign: TextAlign.center,
              ),
              leading: Icon(
                Icons.add_rounded,
              ),
            ),
          ),
        ),
      ),
    );

  }
}