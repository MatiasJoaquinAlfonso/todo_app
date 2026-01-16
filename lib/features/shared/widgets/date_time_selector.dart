import 'package:flutter/material.dart';

class DateTimeSelector extends StatelessWidget {

  final IconData icon;
  final String label1;
  final String value1;
  final VoidCallback? onTap1;
  final String label2;
  final String value2;
  final VoidCallback? onTap2;
  final Widget? trailing;

  const DateTimeSelector({
    super.key, 
    required this.icon, 
    required this.label1, 
    required this.value1, 
    required this.label2, 
    required this.value2,
    this.onTap1,
    this.onTap2,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent, size: 20),
          const SizedBox(width: 12),

          Expanded(
            child: GestureDetector(
              onTap: onTap1,
              behavior: HitTestBehavior.translucent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label1, style: TextStyle(fontSize: 15, color: Colors.grey[400])),
                  Text(
                    value1, 
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Icon(Icons.arrow_forward_ios_rounded, size: 12, color: Colors.grey),
          ),

          Expanded(
            child: GestureDetector(
              onTap: onTap2,
              behavior: HitTestBehavior.translucent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label2, style: TextStyle(fontSize: 15, color: Colors.grey[400])),
                  Text(
                    value2, 
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),

          Container(
            width: 80,
            alignment: Alignment.centerRight,
            child: trailing ?? const SizedBox(),
          )

        ],
      ),

    );
  }
}