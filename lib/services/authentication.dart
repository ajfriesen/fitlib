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
      String email, String password, void Function(FirebaseAuthException e) errorCallback) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }
}