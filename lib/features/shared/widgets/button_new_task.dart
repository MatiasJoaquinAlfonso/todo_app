import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Stitch CTA button — solid primary, no border, full rounded pill.
class ButtonNewTask extends StatelessWidget {
  final VoidCallback onTap;
  final double paddingH;

  const ButtonNewTask({
    super.key,
    required this.onTap,
    this.paddingH = 0,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingH, vertical: 8),
      child: SizedBox(
        height: 48,
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: cs.primary,
            borderRadius: BorderRadius.circular(9999), 
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(9999),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(9999),
              splashColor: Colors.white.withAlpha(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check_circle_outline_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Crear Tarea',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}