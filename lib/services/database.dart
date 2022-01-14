import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_app/models/exercise.dart';
import 'package:flutter_app/models/user.dart' as myUser;
import 'package:image_picker/image_picker.dart';

class Collections {
  static const String exercises = "exercises";
  static const String users = "users";
}

class Database {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static FirebaseStorage _storage = FirebaseStorage.instance;
  static CollectionReference exerciseCollection = _firestore.collection(Collections.exercises);



  /// Get all exercises only once
  static Future<List<Exercise>> getExercises() {
    return exerciseCollection.get().then((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Exercise.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  /// Get all exercises with realtime changes
  static Stream<List<Exercise>> getExercisesWithUpdates() {
    Stream<QuerySnapshot<Object?>> querySnapshot =  exerciseCollection.snapshots();

    Stream<List<Exercise>> stream = querySnapshot.map((document) {
      return document.docs.map((e) {
        return Exercise.fromJson(e.data() as Map<String, dynamic>);
      }).toList();
    });
    return stream;
  }

  /// Get exercise by documentId/exerciseId and return exercise
  static Future<Exercise> getExercise({required String exerciseId}) async {
    Exercise exercise = Exercise.empty();

    DocumentReference<Map<String, dynamic>> documentReference =
        await _firestore.collection(Collections.exercises).doc(exerciseId);
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await documentReference.get();
    if (documentSnapshot.exists) {
      Map<String, dynamic>? documentSnapshotMap = documentSnapshot.data();
      exercise = Exercise.fromJson(documentSnapshotMap!);
    }
    return exercise;
  }

  static Future<String> getImageUrl({required String exerciseId}) async {
    try {
      String imageUrl = await _storage.ref('${Collections.exercises}/$exerciseId/preview').getDownloadURL();
      return imageUrl;
    } on Exception catch (e) {
      print(e);
      return Future.value("");
    }
  }

  /// Add exercise to firebase firestore
  static Future<Exercise?> addExercise(
      {required Exercise exercise, required userId, PickedFile? uploadImage}) async {
    try {
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
      exercise.userId = userId;
      exercise.imageUrl = uploadFileUrl;
      exerciseCollection.doc(randomDoc.id).set(exercise.toJson());
      return exercise;
    } on FirebaseException catch (e) {
      print(e);
      return null;
    }
  }

  ///
  static Future<void> updateExercise(Exercise exercise) async {
    /// get old exercise values
    /// update with new values
    /// TODO: Missing image stuff
    Exercise oldData = Exercise.empty();
    if (exercise.id != null) {
      oldData = await getExercise(exerciseId: exercise.id!);
    }
    exerciseCollection.doc(oldData.id).update(exercise.toJson());
  }

  static Future<String> uploadFile({required PickedFile file, required exerciseId}) async {
    File filePath = File(file.path);

    try {
      await _storage.ref('${Collections.exercises}/$exerciseId/preview').putFile(filePath);
    } on FirebaseException catch (e) {
      print(e);
    }

    String downloadUrl = await _storage.ref('${Collections.exercises}/$exerciseId/preview').getDownloadURL();
    return downloadUrl;
  }

  /// deleteExerciseImageFolder does delete the preview only currently
  // TODO: Find a way to delete all images in a folder.
  // There is not a method for this in flutter, so we need to find a way to store all references to all images
  // and then delete them.
  static Future<void> deleteExerciseImageFolder({required String exerciseId}) {
    return _storage
        .ref('${Collections.exercises}/$exerciseId/preview')
        .delete()
        .then((value) => print("Deleted folder"));
  }

  static Future deleteExercise(Exercise exercise) {
    deleteExerciseImageFolder(exerciseId: exercise.id!);

    return exerciseCollection.doc(exercise.id).delete().then((value) => print("Exercise deleted"));
  }

    static Future<void> addUser({required String email, required String userId}) {
    myUser.User user = myUser.User.empty();
    user.id = userId;
    user.email = email;
    user.updated = DateTime.now();
    user.created = DateTime.now();

    CollectionReference users = FirebaseFirestore.instance.collection(Collections.users);
    return users.doc(user.id).set(user.toJson());
  }
}
