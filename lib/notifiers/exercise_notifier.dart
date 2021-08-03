import 'package:flutter/material.dart';
import 'package:flutter_app/models/exercise.dart';
import 'package:flutter_app/services/database.dart';

class ExerciseNotifier with ChangeNotifier {
  List<Exercise> _exerciseList = [];

  addExerciseToList(Exercise exercise) {
    _exerciseList.add(exercise);
    notifyListeners();
  }

  setExerciseList(List<Exercise> exerciseList) {
    _exerciseList = [];
    _exerciseList = exerciseList;
    notifyListeners();
  }

  List<Exercise> getExerciseList() {
    return _exerciseList;
  }

  Future<String> uploadExercise(Exercise exercise) async {
    return await Database.addExercise(exercise: exercise);
  }
}
