import 'package:flutter/material.dart';
import 'package:flutter_app/models/models.dart';

class ExerciseCard extends StatelessWidget {
  const ExerciseCard({
    Key? key,
    required this.onTap,
    required this.exercise,
  }) : super(key: key);

  final VoidCallback onTap;
  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {},
        leading: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Image.asset(exercise.imageName!),
        ),
        title: Text(exercise.name!),
        trailing: Icon(Icons.more_vert),
      ),
    );
  }
}
