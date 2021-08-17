import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

enum AuthenticationState {
  loggedOut,
  emailAddress,
  register,
  password,
  loggedIn,
}

class Authentication extends ChangeNotifier {
  static FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthenticationState _loginState = AuthenticationState.loggedOut;
  AuthenticationState get loginState => _loginState;

  Stream<User?>? userState;

  Stream<User>? get authStateChanges {
    userState = _firebaseAuth.authStateChanges();
  }

  Future<void> init() async {
    await Firebase.initializeApp();

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loginState = AuthenticationState.loggedIn;
      } else {
        _loginState = AuthenticationState.loggedOut;
      }
      notifyListeners();
    });
  }

  static Future<String?> anonymousLogin() async {
    try {
      await _firebaseAuth.signInAnonymously();
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  static User? getUser() {
    return FirebaseAuth.instance.currentUser;
  }

  ///TODO: Ask about the function as a paremeter. What can I do with this?
  static void registerWithMail(
      String email, String password, void Function(FirebaseAuthException error, String title) errorCallback) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (error) {
      String errorTitle = "Unbekannter Fehler";
      switch (error.code){
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
  static Future<User?> loginWithMail({required String email, required String password}) async {
    String? errorMessage;

    try {
      UserCredential result =  await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    } on FirebaseException catch (e) {
      switch (e.code){
        case "invalid-email":
          errorMessage = "Invalid Email";
          break;
        case "user-disabled":
          errorMessage = "user-disabled";
          break;
        case "user-not-found":
          errorMessage = "user-not-found";
          break;
        case "wrong-password":
          errorMessage = "wrong-password";
          break;
      }
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
  }

}