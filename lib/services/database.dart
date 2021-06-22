import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_app/models/exercise.dart';
import 'package:image_picker/image_picker.dart';

class Database {
  Database(this._firestore, this._storage);

  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  String placeholder = "images/placeholder.png";

  Stream<List<Exercise>> getExercise() {
    return _firestore.collection('exercise').snapshots().map((snapshot) {
      return snapshot.docs.map((document) {
        return Exercise(
            document.data()['id'],
            document.data()['name'],
            document.data()['imageName'],
            document.data()['imageUrl'],
            document.data()['description']);
      }).toList();
    });
  }

  Future<String> getDownloadUrl(String imageName) async {
    try {
      String imageUrl = await _storage.ref(imageName).getDownloadURL();
      return imageUrl;
    } on Exception catch (e) {
      return Future.value(placeholder);
    }
  }

  /// Add entry
  /// TODO:Add exercise instead of strings
  Future<void> addExercise(
      {String? name,
      String? imageName,
      String? imageUrl,
      String? description}) async {
    CollectionReference exercise = _firestore.collection('exercise');

    // Generate an empty document to create the document Id
    DocumentReference<Object?> randomDoc = await exercise.doc();

    return exercise.doc(randomDoc.id).set({
      'id': randomDoc.id,
      'name': name,
      'imageName': imageName,
      'imageUrl': imageUrl,
      'description': description,
    }).then((value) => print('Added exercise'));
  }

  Future<void> uploadFile(PickedFile pickedFile, String fileName) async {
    File file = File(pickedFile.path);

    try {
      await _storage.ref(fileName).putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future<void> deleteExercise(Exercise exercise) {
    CollectionReference exercises =
        FirebaseFirestore.instance.collection('exercise');
    return exercises
        .doc(exercise.id)
        .delete()
        .then((value) => print("Exercise deleted"));
  }
}
