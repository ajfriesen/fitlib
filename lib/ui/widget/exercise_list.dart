import 'package:flutter/material.dart';
import 'package:fitlib/models/exercise.dart';
import 'package:fitlib/ui/widget/exercise_card.dart';

class ExerciseList extends StatelessWidget {
  final List<Exercise> exercises;                      // title: Text(snapshot.data![index].name!),
  final itemcCount;

  ExerciseList({required this.exercises, required this.itemcCount});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemcCount,
      itemBuilder: (context, index) {
        final exercise = this.exercises[index];
        return ExerciseCard(exercise);
      },
    );
  }
}
