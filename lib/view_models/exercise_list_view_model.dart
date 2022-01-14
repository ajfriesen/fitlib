import 'package:fitlib/models/exercise.dart';

class ExerciseListViewModel {
  final Exercise exercise;

  ExerciseListViewModel({required this.exercise});

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
