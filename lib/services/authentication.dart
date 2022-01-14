import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'database.dart';

class Authentication extends ChangeNotifier {

  final FirebaseAuth firebaseAuth;

  Authentication({required this.firebaseAuth});

  Future<String?> anonymousLogin() async {
    try {
      await firebaseAuth.signInAnonymously();
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  User? getUser() {
    return firebaseAuth.currentUser;
  }

  ///TODO: Ask about the function as a paremeter. What can I do with this?
  void registerWithMail(
    String email,
    String password,
    void Function(FirebaseAuthException error, String title) errorCallback,
  ) async {
    try {
      UserCredential registeredUser = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      if (registeredUser != null || registeredUser.user != null) {
        await Database.addUser(email: email, userId: registeredUser.user!.uid);
      }
    } on FirebaseAuthException catch (error) {
      String errorTitle = "Unbekannter Fehler";
      switch (error.code) {
        case "email-already-in-use":
          errorTitle = "E-Mail schon vorhanden";
          break;
        case "invalid-email":
          errorTitle = "Keine valide E-Mail";
          break;
        case "operation-not-allowed":
          errorTitle = "E-Mail Authentifizierung nicht erlaubt";
          break;
        case "weak-password":
          errorTitle = "Password zu schwach";
          break;
      }
      errorCallback(error, errorTitle);
    }
  }

  ///TODO: Ask about the function as a paremeter. What can I do with this?
  ///TODO: Removed the function parameter since I do not know how to use it.
  ///#TODO: Can I use named parameters in a functions which is a paramter already?
  Future<User?> loginWithMail(
      {required String email,
      required String password,
      required void Function(FirebaseAuthException error, String title) errorCallback}) async {
    try {
      UserCredential result =
          await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    } on FirebaseAuthException catch (error) {
      String errorTitle = "Unbekannter Fehler";

      switch (error.code) {
        case "invalid-email":
          errorTitle = "Invalid Email";
          break;
        case "user-disabled":
          errorTitle = "user-disabled";
          break;
        case "user-not-found":
          errorTitle = "user-not-found";
          break;
        case "wrong-password":
          errorTitle = "Falsches Passwort";
          break;
      }
      errorCallback(error, errorTitle);
    }
  }

  signOut() {
    firebaseAuth.signOut();
  }
}
