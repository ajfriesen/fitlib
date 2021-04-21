import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/models/exercise.dart';

class ExerciseService {
  static Future<List<Exercise>> getGlobalExerciseList() async {
    Stream<QuerySnapshot> exercises =
        FirebaseFirestore.instance.collection('excercise').snapshots();
    print(exercises);
    List<QuerySnapshot> exerciseCollection = await exercises.toList();

    List<QueryDocumentSnapshot> exerciseDocuments =
        exerciseCollection.first.docs;

    for (var i; i < exerciseDocuments; i++) {
      print(exerciseDocuments.elementAt(i));
    }
    return Future.value(List.empty());
  }
}
