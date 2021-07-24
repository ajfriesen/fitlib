import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_app/models/exercise.dart';
import 'package:image_picker/image_picker.dart';

class Database {
  Database(this._firestore, this._storage);

  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

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

  Future<String> getImageUrl({required String exerciseId}) async {
    try {
      String imageUrl = await _storage.ref('exercise/$exerciseId/preview').getDownloadURL();
      return imageUrl;
    } on Exception catch (e) {
      print(e);
      return Future.value("");
    }
  }

  /// Add entry
  Future<String> addExercise({required Exercise exercise, PickedFile? uploadImage}) async {
    CollectionReference exerciseCollection = _firestore.collection('exercise');

    /// Generate an empty document to create the document Id
    DocumentReference<Object?> randomDoc = await exerciseCollection.doc();
    String uploadFileUrl;

    /// Only upload image if image is not null or empty string
    if ( uploadImage != null && uploadImage.path != ""){
      uploadFileUrl = await uploadFile(file: uploadImage, exerciseId: randomDoc.id);
    } else {
      uploadFileUrl = "";
    }

    /// Map entered values to exercise entry in firebase
    exercise.id = randomDoc.id;
    exercise.imageUrl = uploadFileUrl;
    exerciseCollection.doc(randomDoc.id).set(exercise.toJson()).then((value) => print('Added exercise'));

    return randomDoc.id;
  }

  Future<String> uploadFile({required PickedFile file, required exerciseId}) async {
    File filePath = File(file.path);

    try {
      await _storage.ref('exercise/$exerciseId/preview').putFile(filePath);
    } on FirebaseException catch (e) {
      print(e);
    }

    String downloadUrl = await _storage.ref('exercise/$exerciseId/preview').getDownloadURL();
    return downloadUrl;
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
