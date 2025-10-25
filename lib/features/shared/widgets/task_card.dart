import 'package:flutter/material.dart';


class TaskCard extends StatelessWidget {

  final String title;
  final String subTitle;
  final String longDescription;
  final double borderRadius;
  final VoidCallback onTap;

  const TaskCard({
    super.key, 
    required this.title, 
    this.subTitle = '', 
    required this.longDescription,
    required this.borderRadius, 
    required this.onTap, 
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent
      ),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: ExpansionTile(

            title: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onTap,
              child: Text(title,)
            ),
            subtitle: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onTap,
              child: Text(
                subTitle, 
                // style: style,
                maxLines: 1, 
                overflow: TextOverflow.ellipsis,
              ),
            ),
          
            children: [
              Container(
                color: Theme.of(context).colorScheme.surfaceContainerLowest,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),//fromLTRB(15, 10, 15, 5),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      longDescription,
                      style: TextStyle(fontSize: 15),
                    ),
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
      ),
      );
  }
}