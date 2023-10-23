import 'package:flutter/material.dart';

class ExerciseList extends StatelessWidget {
  const ExerciseList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercise List"),
        actions: const [
          Icon(Icons.more_vert),
        ],
      ),
      body: ListView(
        children: [],
      ),
    );
  }
}
