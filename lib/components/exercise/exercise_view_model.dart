import 'package:flutter_app/models/exercise.dart';

class ExerciseViewModel {

  final Exercise exercise;

  ExerciseViewModel({required this.exercise});


  String? get name {
    if (this.exercise.name != null) {
      return this.exercise.name;
    }
  }

  String? get description {
    if (this.exercise.description != null) {
      return this.exercise.description;
    }
  }

  String? get imageUrl {
    if (this.exercise.imageUrl != null) {
      return this.exercise.imageUrl;
    }
  }
}