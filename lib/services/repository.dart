import 'package:flutter_app/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Repository {
  Repository(this._firestore) : assert(_firestore != null);

  final FirebaseFirestore _firestore;

  Stream<List<Exercise>> getExercise() {
    return _firestore.collection('exercise').snapshots().map((snapshot) {
      return snapshot.docs
          .map((document) {
            return Exercise(document.data()['name'], document.data()['imageUrl']);
          })
          .toList();
    });
  }
}
