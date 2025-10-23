import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:todo_app/config/providers/theme_provider.dart';

class HomePage extends ConsumerWidget {


  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // final isDarkMode = ref.watch( themeNotifierProvider).isDarkMode;
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('TO-DO APP'),
        // backgroundColor: Colors.blue.shade600,
        actionsPadding: EdgeInsets.symmetric(horizontal: 10),
        actions: [
          IconButton(
            onPressed: () {
              
            },
            icon: Icon(Icons.dark_mode_outlined),
          )
        ],
      ),
      // backgroundColor: Colors.white70,
      body: Center(
        // child: 
      ),

    );
  }
}