import 'package:flutter/material.dart';
import 'package:flutter_app/models.dart';
import 'package:flutter_app/exercsise_card.dart';

final List<Exercise> _exerciseList = [
  Exercise(name: "Push-Up", imageUrl: "images/push-ups.jpg"),
  Exercise(name: "Pull-Up", imageUrl: "images/pull-up.jpeg"),
  Exercise(name: "Squat", imageUrl: "images/squat.jpeg"),
  Exercise(name: "Burpee", imageUrl: "images/burpee.jpeg"),
  Exercise(name: "Knee Push Up", imageUrl: "images/knee-push-up.jpeg"),
  Exercise(name: "Crunches", imageUrl: "images/crunches.jpeg"),
  Exercise(name: "Russian Twist", imageUrl: "images/russian-twist.jpeg"),
];

class MyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        for (final exercise in _exerciseList) ...[
          ExerciseCard(
            exercise: exercise,
            onTap: () {},
          ),
        ],
      ],
    );
  }
}
