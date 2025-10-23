import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('TO-DO APP'),
        backgroundColor: Colors.blue.shade600,
        actionsPadding: EdgeInsets.symmetric(horizontal: 10),
        actions: [
          Icon(Icons.dark_mode_outlined)
        ],
      ),
      backgroundColor: Colors.white70,
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(20),
          ),
        )
      ),

    );
  }
}