import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

// Example this is based off:
//  https://firebase.google.com/codelabs/firebase-get-to-know-flutter#4
//

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

  AuthenticationNotifier(){
    init();
  }

  Future<void> init()async {
    _firebaseAuth.userChanges().listen((user) {
        if (user == null){
          _loginState = ApplicationLoginState.loggedOut;
        }
        if (user != null){
          _loginState = ApplicationLoginState.loggedIn;
        }
      }
    );
    notifyListeners();
  }
}


