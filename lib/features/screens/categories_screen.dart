import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            color: Colors.white,
            elevation: 100,
            shadowColor: Colors.red,
          ),
        ],
      ),
    );
  }
}