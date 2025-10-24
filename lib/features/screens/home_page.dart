import 'package:flutter/material.dart';
import 'package:todo_app/features/shared/widgets/widgets.dart';

class HomePage extends StatelessWidget {

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    
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
      // Despues agregar la propiedad .Builder para hacer una lista infinita
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        children: [
          TaskCard(
            title: 'Title', 
            subTitle: 'Sub title',
            borderRadius: 15,
            longDescription: 'Aliqua laboris aliquip voluptate tempor laborum ea duis aliqua nostrud commodo aliqua elit elit. Occaecat ut sint incididunt eiusmod labore ex est culpa.',
          ),
        ],
      ),

    );
  }
}