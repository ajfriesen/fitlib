import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

enum ApplicationLoginState {
  loggedOut,
  emailAddress,
  register,
  password,
  loggedIn,
}

class AuthenticationNotifier extends ChangeNotifier {

  static FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;

  ApplicationLoginState get loginState => _loginState;



  Future<void> listenUserChange() async {
    _firebaseAuth.userChanges().listen((user) {
      if (user != null) {
        _loginState = ApplicationLoginState.loggedIn;
      } else {
        _loginState = ApplicationLoginState.loggedOut;
      }
      notifyListeners();
    });
  }

}


