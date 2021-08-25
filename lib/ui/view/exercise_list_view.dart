import 'package:flutter/material.dart';
import 'package:flutter_app/models/exercise.dart';
import 'package:flutter_app/notifiers/exercise_notifier.dart';
import 'package:flutter_app/services/route_generator.dart';
import 'package:provider/provider.dart';
import '../../view_models/exercise_list_view_model.dart';

class ExerciseListView extends StatefulWidget {
  final Exercise exercise;

  ExerciseListView({required this.exercise});

  @override
  State createState() {
    return ExerciseListViewState(exercise);
  }
}

class ExerciseListViewState extends State<ExerciseListView> {
  Exercise exercise;
  ExerciseListViewModel? exerciseViewModel;
  static const String placeholder = "images/placeholder.png";

  ExerciseListViewState(this.exercise) {
    exerciseViewModel = new ExerciseListViewModel(exercise: exercise);
  }

  _deleteExerciseOnPressed(BuildContext context) {
    ExerciseNotifier exerciseNotifier = Provider.of(context, listen: false);
    exerciseNotifier.deleteExercise(exercise);
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
                              _deleteExerciseOnPressed(context);
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
          Navigator.of(context)
              .pushNamed(RouterGenerator.exerciseDetailViewRoute, arguments: widget.exercise);
        },
      ),
    );
  }
}
