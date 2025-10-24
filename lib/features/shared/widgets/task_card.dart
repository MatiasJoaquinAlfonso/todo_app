import 'package:flutter/material.dart';


class TaskCard extends StatelessWidget {

  final String title;
  final String subTitle;
  final String longDescription;
  final double borderRadius;

  const TaskCard({
    super.key, 
    required this.title, 
    this.subTitle = '', 
    required this.longDescription,
    required this.borderRadius, 
  });

  @override
  Widget build(BuildContext context) {
    return 
      Card(
        elevation: 2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: ExpansionTile(
            title: Text(title,),
            subtitle: Text(
              subTitle, 
              // style: style,
              maxLines: 1, 
              overflow: TextOverflow.ellipsis,
            ),
          
            children: [
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    longDescription,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              )
          
            ],
          
            // collapsedBackgroundColor: ,
            // trailing: IconButton(
            //   onPressed: () {}, 
            //   icon: Icon(Icons.keyboard_arrow_down_rounded)
            // ),
          ),
        ),
      );
  }
}