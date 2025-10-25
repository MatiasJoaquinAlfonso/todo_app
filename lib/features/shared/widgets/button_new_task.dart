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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingH, vertical: 8),
      child: DottedBorder(
        // options: DottedBorderOptions(
        //   borderType: BorderRadius.all(15),
        //   color: Colors.blueAccent,

        // ),
        // options: RectDottedBorderOptions(
        //   dashPattern: [10, 5],
        //   strokeWidth: 2,
        //   padding: EdgeInsets.all(16), 
        // ),
        // options: CustomPathDottedBorderOptions(
        //   padding: const EdgeInsets.all(8),
        //   color: Colors.blue,
        //   strokeWidth: 2,
        //   dashPattern: [10, 5],
        //   customPath: (size) => Path()
        //     ..moveTo(0, size.height)
        //     ..relativeLineTo(size.width, 0),
        // ),
        options: RoundedRectDottedBorderOptions(
          radius: Radius.circular(15),
          color: Colors.lightBlue,
          strokeWidth: 1.5,
          dashPattern: [6, 4],
          padding: EdgeInsets.zero
        ),
        child: Card(
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