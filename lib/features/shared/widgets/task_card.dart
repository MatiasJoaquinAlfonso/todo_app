import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class TaskCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final DateTime dateInit;
  final DateTime dateFinish;
  final double borderRadius;
  final VoidCallback onTap;
  final Future<bool?> Function()? onSwipeLeft;
  final Future<bool?> Function()? onSwipeRight;
  final Widget? background;
  final Widget? secondaryBackground;
  final String dismissKey;
  final String? categoryName;
  final Color? categoryColor;
  final int? categoryPriority;

  const TaskCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.dateInit,
    required this.dateFinish,
    required this.onTap,
    this.borderRadius = 16.0,
    this.onSwipeLeft,
    this.onSwipeRight,
    this.background,
    this.secondaryBackground,
    required this.dismissKey,
    this.categoryName,
    this.categoryColor,
    this.categoryPriority,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    // Build the list tile exactly as Stitch designed it
    final inner = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Checkbox outline mock
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: cs.primary, width: 2),
                ),
              ),
              const SizedBox(width: 16),
              
              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: cs.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.access_time_rounded, size: 10, color: cs.primary),
                        const SizedBox(width: 4),
                        Text(
                          TimeOfDay.fromDateTime(dateInit).format(context),
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                        if (categoryName != null) ...[
                          const SizedBox(width: 6),
                          Text(
                            '•',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            categoryName!.toUpperCase(),
                            style: GoogleFonts.inter(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: cs.onSurfaceVariant,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              
              // More options
              Icon(
                Icons.more_vert_rounded,
                size: 20,
                color: cs.onSurfaceVariant.withAlpha(150),
              ),
            ],
          ),
        ),
      ),
    );

    // If swipeable, wrap in Dismissible
    if (onSwipeLeft != null || onSwipeRight != null) {
      return Container(
        margin: const EdgeInsets.only(bottom: 8),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Dismissible(
          key: Key(dismissKey),
          background: background ?? Container(color: cs.primaryContainer),
          secondaryBackground: secondaryBackground ?? Container(color: cs.error),
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.endToStart && onSwipeLeft != null) {
              return await onSwipeLeft!();
            } else if (direction == DismissDirection.startToEnd &&
                onSwipeRight != null) {
              return await onSwipeRight!();
            }
            return false;
          },
          child: inner,
        ),
      );
    }

    // Default return
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: inner,
    );
  }
}