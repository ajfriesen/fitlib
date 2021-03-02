import 'package:flutter/material.dart';
import 'package:flutter_app/models/models.dart';
import 'package:flutter_app/components/exercsise_card.dart';

class MyList extends StatelessWidget {
  List<Exercise> exerciseList;

  MyList(recievedExerciseList) {
    exerciseList = recievedExerciseList;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        for (final exercise in exerciseList) ...[
          ExerciseCard(
            exercise: exercise,
            onTap: () {},
          ), // check for empty list
        ],
      ],
    );
  }
}
