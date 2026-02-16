import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class DialogUtils {

  static void show({
    required BuildContext context,
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    bool isError = false,

    String? otherActionText,
    VoidCallback? onOtherAction,

  }) {
    showDialog(
      context: context, 
      builder: (context) => AlertDialog.adaptive(
        title: Text(title),
        content: Text(message),
        actions: [

          if(cancelText != null)
            TextButton(
              onPressed: () => context.pop(), 
              child: Text(cancelText, style: TextStyle(color: Colors.blue)),
            ),

          if (otherActionText != null)
            TextButton(
              onPressed: () {
                context.pop();
                if(onOtherAction != null) onOtherAction();
              },
              child: Text(otherActionText, style: TextStyle(color: Colors.amber)),
            ),

          TextButton(
            onPressed: () {
              context.pop();
              if (onConfirm != null) onConfirm();  
            }, 
            child: Text(
              confirmText ?? 'OK',
              style: TextStyle(
                color: isError ? Colors.red : Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      )

    );
  }

}