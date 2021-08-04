import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_app/models/exercise.dart';
import 'package:flutter_app/notifiers/exercise_notifier.dart';
import 'package:image_picker/image_picker.dart';

class Database {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static FirebaseStorage _storage = FirebaseStorage.instance;
  static CollectionReference exerciseCollection = _firestore.collection('exercise');

  static void getExercises(ExerciseNotifier exerciseNotifier) {
    // List<Exercise> exerciseList = [];
    //
    // exerciseCollection
    //     .get()
    //     .then((QuerySnapshot querySnapshot) {
    //   querySnapshot.docs.forEach((doc) {
    //     exerciseList.add(Exercise.fromJson(doc.data() as Map<String, dynamic>));
    //   });
    // }).then((value) => exerciseNotifier.setExerciseList(exerciseList));

    exerciseCollection
        .get()
        .then((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Exercise.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    }).then((value) => exerciseNotifier.setExerciseList(value));
  }

  /// Get exercise by documentId/exerciseId and return exercise
  static Future<Exercise> getExercise({required String exerciseId}) async {
    Exercise exercise = Exercise.empty();

    DocumentReference<Map<String, dynamic>> documentReference =
        await _firestore.collection('exercise').doc(exerciseId);
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await documentReference.get();
    if (documentSnapshot.exists) {
      Map<String, dynamic>? documentSnapshotMap = documentSnapshot.data();
      exercise = Exercise.fromJson(documentSnapshotMap!);
    }
    return exercise;
  }

  static Future<String> getImageUrl({required String exerciseId}) async {
    try {
      String imageUrl = await _storage.ref('exercise/$exerciseId/preview').getDownloadURL();
      return imageUrl;
    } on Exception catch (e) {
      print(e);
      return Future.value("");
    }
  }

  /// Add exercise to firebase firestore
  static Future<String> addExercise({required Exercise exercise, PickedFile? uploadImage}) async {
    CollectionReference exerciseCollection = _firestore.collection('exercise');

    /// Generate an empty document to create the document Id
    DocumentReference<Object?> randomDoc = await exerciseCollection.doc();
    String uploadFileUrl;

    /// Only upload image if image is not null or empty string
    if (uploadImage != null && uploadImage.path != "") {
      uploadFileUrl = await uploadFile(file: uploadImage, exerciseId: randomDoc.id);
    } else {
      uploadFileUrl = "";
    }

    /// Map entered values to exercise entry in firebase
    exercise.id = randomDoc.id;
    exercise.imageUrl = uploadFileUrl;
    exerciseCollection
        .doc(randomDoc.id)
        .set(exercise.toJson())
        .then((value) => print('Added exercise'));

    return randomDoc.id;
  }

  static Future<String> uploadFile({required PickedFile file, required exerciseId}) async {
    File filePath = File(file.path);

    try {
      await _storage.ref('exercise/$exerciseId/preview').putFile(filePath);
    } on FirebaseException catch (e) {
      print(e);
    }

    String downloadUrl = await _storage.ref('exercise/$exerciseId/preview').getDownloadURL();
    return downloadUrl;
  }

  /// deleteExerciseImageFolder does delete the preview only currently
  // TODO: Find a way to delete all images in a folder.
  // There is not a method for this in flutter, so we need to find a way to store all references to all images
  // and then delete them.
  static Future<void> deleteExerciseImageFolder({required String exerciseId}) {
    return _storage
        .ref('exercise/$exerciseId/preview')
        .delete()
        .then((value) => print("Deleted folder"));
  }

  static Future deleteExercise(Exercise exercise) {
    CollectionReference exercises = FirebaseFirestore.instance.collection('exercise');

    deleteExerciseImageFolder(exerciseId: exercise.id!);

    return exercises.doc(exercise.id).delete().then((value) => print("Exercise deleted"));
  }
}
