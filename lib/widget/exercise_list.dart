import 'package:flutter/material.dart';
import 'package:flutter_app/components/exercise/exercise_list_view_model.dart';

class ExerciseList extends StatelessWidget {
  final List<ExerciseListViewModel> exercises;

  ExerciseList({required this.exercises});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.exercises.length,
      itemBuilder: (context, index) {
        final exercise = this.exercises[index];

        return ListTile(
          contentPadding: EdgeInsets.all(10),
          leading: Container(
            decoration: BoxDecoration(
                // image: DecorationImage(
                //     fit: BoxFit.cover,
                //     image: NetworkImage(exercise.poster)
                // ),
                borderRadius: BorderRadius.circular(6)),
            width: 50,
            height: 100,
          ),
          title: Text(exercise.name!),
        );
      },
    );
  }
}
