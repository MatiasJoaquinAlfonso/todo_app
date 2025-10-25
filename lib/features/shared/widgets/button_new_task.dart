import 'package:flutter/material.dart';

class ButtonNewTask extends StatelessWidget {

  final VoidCallback onTap;

  const ButtonNewTask({
    super.key, 
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 4,
        child: InkWell(
          onTap: onTap,
          child: ListTile(
            title: Text(
              'Agregar nueva tarea.',
              textAlign: TextAlign.center,
            ),
            leading: Icon(
              Icons.add_rounded,
              textDirection: TextDirection.rtl,
            ),
          ),
        ),
      ),
      // child: Card(
      //   elevation: 2,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(15),
      //     side: BorderSide(
      //       color: Theme.of(context).colorScheme.outline,
      //       width: 1.5,
      //     ),
      //   ),
      //   clipBehavior: Clip.antiAlias,
      //   child: InkWell(
      //     onTap: () {
      //     },
      //     child: Center(
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Icon(
      //             Icons.add_rounded,
      //             color: Theme.of(context).colorScheme.primary,
      //           ),
      //           const SizedBox(width: 12),
      //           Text(
      //             'Añadir nueva tarea.',
      //             style: TextStyle(
                    
      //             ),
      //           ),

      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );

  }
}