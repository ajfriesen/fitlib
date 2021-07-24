import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/exercise.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/services/route_generator.dart';

class ExerciseCard extends StatefulWidget {
  @override
  _ExerciseCardState createState() => _ExerciseCardState();
  ExerciseCard(this.exercise);
  final Exercise exercise;
}

class _ExerciseCardState extends State<ExerciseCard> {
  final Database database =
      Database(FirebaseFirestore.instance, FirebaseStorage.instance);

  static const String placeholder = "images/placeholder.png";

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.exercise.name!),
        leading: widget.exercise.imageUrl != ""
            ? Image.network(widget.exercise.imageUrl!)
            : Image.asset(placeholder),
        subtitle: widget.exercise.description != null
            ? Text(widget.exercise.description!)
            : Text(""),
        trailing: IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: const Text("Warnung"),
                        content:
                            const Text("Soll diener Eintrag geloescht werden?"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              database.deleteExercise(widget.exercise);
                              Navigator.pop(context, 'Delete');
                            },
                            child: const Text('Delete'),
                          ),
                        ],
                      ));
              ;
            }),
        onTap: () {
          Navigator.of(context).pushNamed(
              RouterGenerator.exerciseDetailViewRoute,
              arguments: widget.exercise);
        },
      ),
    );
  }
}
