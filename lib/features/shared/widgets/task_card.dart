import 'package:flutter/material.dart';


class TaskCard extends StatelessWidget {

  final String title;
  final String subTitle;
  final double borderRadius;
  final VoidCallback onTap;

  final Color? categoryColor;
  final String? categoryName;
  final int? categoryPriority;
  final DateTime dateInit;
  final DateTime dateFinish;

  final String? dismissKey;
  final Widget? background;
  final Widget? secondaryBackground;
  final Future<bool?> Function()? onSwipeLeft; 
  final Future<bool?> Function()? onSwipeRight; 

  const TaskCard({
    super.key, 
    required this.title, 
    this.subTitle = '', 
    required this.borderRadius, 
    required this.onTap, 
    this.categoryColor, 
    this.categoryName, 
    this.categoryPriority, 
    required this.dateInit, 
    required this.dateFinish,
    this.dismissKey,
    this.background,
    this.secondaryBackground,
    this.onSwipeLeft,
    this.onSwipeRight,
  });

  String get _priorityText {
    switch (categoryPriority) {
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
    switch (categoryPriority) {
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;

    final backgroundColor = categoryColor != null
      ? (isLight
          ? HSLColor.fromColor(categoryColor!).withLightness(0.40).toColor()
          : HSLColor.fromColor(categoryColor!).withLightness(0.25).toColor())
      : Theme.of(context).colorScheme.surfaceContainerLowest;

    Widget cardContent = Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: Container(
        color: categoryColor != null
          ? backgroundColor
          : (isLight ? Color(0xFFFFFFFF) : theme.colorScheme.surfaceContainerLowest),
          // : Color(0xFFFFFFFF),
        child: ExpansionTile(

          title: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: Text(
              title,
              style: TextStyle(
                // color: categoryColor != null ? Colors.white70 : theme.colorScheme.onSurface
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
              )
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                categoryName ?? 'Sin categoría',
                style: TextStyle(
                    color: theme.colorScheme.onSurface,
                    // color: categoryColor != null 
                    //   ? Colors.white 
                    //   : theme.colorScheme.onSurface
                  ),
                ),
              if (categoryPriority != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    // color: theme.colorScheme.onSurface,
                    color: Colors.white,
                    // color: isLight
                    //     ? Colors.white.withAlpha(210)
                    //     : theme.colorScheme.onSurface,
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
                          color: isLight
                            ? theme.colorScheme.onSurface
                            : theme.colorScheme.onInverseSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          children: [
            Container(
              // color: Theme.of(context).colorScheme.surfaceContainerLowest,
              color: backgroundColor,

              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Icon(
                                Icons.play_circle_outline_outlined,
                                color: theme.colorScheme.onSurface,
                                // color: categoryColor != null 
                                //   ? Colors.white 
                                //   : theme.colorScheme.onSurface
                              ),
                              title: Text(
                                'Inicio', 
                                style: TextStyle(
                                  fontWeight: FontWeight.bold, 
                                  fontSize: 14,
                                  color: theme.colorScheme.onSurface,
                                  // color: categoryColor != null 
                                  //   ? Colors.white 
                                  //   : theme.colorScheme.onSurface  
                                )
                              ),
                              subtitle: Text(
                                '${dateInit.day}/${dateInit.month}/${dateFinish.year} - ${dateInit.hour}:${dateInit.minute.toString().padLeft(2, '0')}',
                                style: TextStyle(
                                  color: theme.colorScheme.onSurface,
                                  // color: categoryColor != null 
                                  //   ? Colors.white 
                                  //   : theme.colorScheme.onSurface 
                                )
                              ),
                            ),
                          ),

                          Expanded(
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Icon(
                                Icons.stop_circle_outlined,
                                // color: categoryColor != null ? Colors.white : theme.colorScheme.onSurface,
                                color: theme.colorScheme.onSurface,
                              ),
                              title: Text(
                                'Fin', 
                                style: TextStyle(
                                  fontWeight: FontWeight.bold, 
                                  fontSize: 14,
                                  // color: categoryColor != null ? Colors.white : theme.colorScheme.onSurface,
                                  color: theme.colorScheme.onSurface,
                                )),
                              subtitle: Text(
                                '${dateFinish.day}/${dateFinish.month}/${dateFinish.year} - ${dateFinish.hour}:${dateFinish.minute.toString().padLeft(2, '0')}',
                                style: TextStyle(
                                  // color: categoryColor != null ? Colors.white : theme.colorScheme.onSurface 
                                  color: theme.colorScheme.onSurface,
                                )
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
        
          ],
          
        ),
      ),
    );

    Widget finalWidget;

    if (dismissKey != null && (onSwipeLeft != null || onSwipeRight != null)) {
      finalWidget = Dismissible(
        key: Key(dismissKey!),
        background: background,
        secondaryBackground: secondaryBackground,
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.startToEnd && onSwipeRight != null) {
            return onSwipeRight!();
          } else if (direction == DismissDirection.endToStart && onSwipeLeft != null) {
            return onSwipeLeft!();
          }
          return false;
        },
        child: cardContent,
      );
    } else {
      finalWidget = cardContent;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: finalWidget,
      ),
    );
  }
}