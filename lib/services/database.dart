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
            id: document.data()['id'],
            name: document.data()['name'],
            imageName: document.data()['imageName'],
            imageUrl: document.data()['imageUrl'],
            description: document.data()['description']);
      }).toList();
    });
  }

  /// Get exercise by documentId/exerciseId and return exercise
  Future<Exercise> getExercise({required String exerciseId}) async {
    Exercise exercise = Exercise.empty();

    DocumentReference<Map<String, dynamic>> documentReference = await _firestore.collection('exercise').doc(exerciseId);
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await documentReference.get();
    if (documentSnapshot.exists ) {
      Map<String, dynamic>? documentSnapshotMap = documentSnapshot.data();
      exercise = Exercise.fromJson(documentSnapshotMap!);
    }
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
