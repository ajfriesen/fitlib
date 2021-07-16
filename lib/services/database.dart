import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_app/models/exercise.dart';
import 'package:flutter_app/services/route_generator.dart';
import 'package:image_picker/image_picker.dart';

class Database {
  Database(this._firestore, this._storage);

  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  String placeholder = "images/placeholder.png";

  Stream<List<Exercise>> getExercises() {
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

  // TODO: Try implementing a get exercise from single document id
  Future<Exercise> getExercise({required String documentReference}) async{
    Exercise exercise = Exercise.empty();

    // TODO: Try implementing a get exercise from single document id
    return exercise;

  }

  Future<String> getImageUrl({required String imageName}) async {
    try {
      String imageUrl = await _storage.ref(imageName).getDownloadURL();
      return imageUrl;
    } on Exception catch (e) {
      return Future.value(placeholder);
    }
  }

  /// Add entry
  /// TODO:Add exercise instead of strings
  Future<String> addExercise(
      {String? name,
      String? imageName,
      String? imageUrl,
      String? description,
      PickedFile? uploadImage
      }) async {
    CollectionReference exercise = _firestore.collection('exercise');

    /// Generate an empty document to create the document Id
    DocumentReference<Object?> randomDoc = await exercise.doc();

    exercise.doc(randomDoc.id).set({
      'id': randomDoc.id,
      'name': name,
      'imageName': imageName,
      'imageUrl': imageUrl,
      'description': description,
    }).then((value) => print('Added exercise'));

    //TODO:
    /// Only upload image if image is not null or empty string
    if ( uploadImage != null || uploadImage != ""){
      uploadFile(file: uploadImage!, exerciseId: randomDoc.id, exerciseName: name);
    }


    return randomDoc.id;

  }

  Future<void> uploadFile({required PickedFile file, required exerciseId, required exerciseName}) async {
    File filePath = File(file.path);

    try {
      await _storage.ref('exercise/$exerciseId/$exerciseName').putFile(filePath);
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
