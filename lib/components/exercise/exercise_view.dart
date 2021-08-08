import 'package:flutter/material.dart';
import 'package:flutter_app/models/exercise.dart';
import 'package:flutter_app/services/route_generator.dart';

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
  static const String placeholder = "images/placeholder.png";

  ExerciseViewState(this.exercise) {
    exerciseViewModel = new ExerciseViewModel(exercise: exercise);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: new ListTile(
        title: Text(exerciseViewModel!.name!),
        leading: widget.exercise.imageUrl != ""
            ? Image.network(widget.exercise.imageUrl!)
            : Image.asset(placeholder),
        subtitle: Text(exerciseViewModel!.description!),
          trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text("Warnung"),
                      content: const Text("Soll dieser Eintrag geloescht werden?"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Database.deleteExercise(widget.exercise);
                            Navigator.pop(context, 'Delete');
                          },
                          child: const Text('Delete'),
                        ),
                      ],
                    ));
                ;
              }),
        onTap: () {
          //TODO:add route
          // Navigator.of(context).pushNamed(RouterGenerator.exerciseDetailViewRoute, arguments: widget.exercise);
        },
      ),
    );
  }
}
