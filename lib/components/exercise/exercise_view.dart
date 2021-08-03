import 'package:flutter/material.dart';
import 'package:flutter_app/models/exercise.dart';

import 'exercise_view_model.dart';

class ExerciseView extends StatefulWidget {
  final Exercise exercise;

  ExerciseView({required this.exercise});

  @override
  State createState() {
    return ExerciseViewState(exercise);
  }
}

class ExerciseViewState extends State<ExerciseView> {
  Exercise exercise;
  ExerciseViewModel? exerciseViewModel;

  ExerciseViewState(this.exercise) {
    exerciseViewModel = new ExerciseViewModel(exercise: exercise);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: new Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 0,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 0,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            exerciseViewModel!.name!,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: Divider(
                height: 1,
              ),
            ),
            Expanded(
              flex: 0,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(exerciseViewModel!.description!),
              ),
            ),
            Expanded(
              flex: 0,
              child: Divider(
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
