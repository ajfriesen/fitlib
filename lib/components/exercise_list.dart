import 'package:flutter/material.dart';
import 'package:flutter_app/models/exercise.dart';
import 'package:flutter_app/services/database.dart';
import 'package:provider/provider.dart';

import 'exercise_card.dart';

class MyList extends StatefulWidget {
  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  Stream<List<Exercise>>? _exerciseStream;

  @override
  void initState() {
    super.initState();
    _exerciseStream = context.read<Database>().getExercises();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Exercise>>(
        stream: _exerciseStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<Exercise>> snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text('Waiting');
            default:
              return ListView(
                children: snapshot.data!.map((Exercise exercise) {
                  return ExerciseCard(exercise);
                }).toList(),
              );
          }
        });
  }
}
