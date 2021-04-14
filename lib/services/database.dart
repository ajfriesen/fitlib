import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_app/models/models.dart';

class Database {
  Database(this._firestore);

  final FirebaseFirestore _firestore;
  String placeholder = "images/placeholder.png";

  Stream<List<Exercise>> getExercise() {
    return _firestore.collection('exercise').snapshots().map((snapshot) {
      return snapshot.docs.map((document) {
        return Exercise(document.data()!['name'], document.data()!['imageName'],
            document.data()!['imageUrl']);
      }).toList();
    });
  }

  Future<String> getDownloadUrl(String imageName) async {
    try {
      String imageUrl = await firebase_storage.FirebaseStorage.instance
          .ref(imageName)
          .getDownloadURL();
      return imageUrl;
    } on Exception catch (e) {
      return Future.value(placeholder);
    }
  }
}
