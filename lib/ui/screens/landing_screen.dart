import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fitlib/notifiers/authentication_notifier.dart';
import 'package:fitlib/ui/screens/login_screen.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingScreen> {

  // User? user;


  // @override
  // void initState() {
  //
  //   AuthenticationNotifier authenticationNotifier = Provider
  //       .of<AuthenticationNotifier>(context, listen: false);
  //   authenticationNotifier.listenUserChange();
  //   super.initState();
  // }

  // void printUserId(User? user) {
  //   print('User ID: ${user?.uid}');
  // }
  // ApplicationLoginState loginInformation = ApplicationLoginState.loggedOut;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationNotifier>(
      builder: (context, appState, _){
        switch (appState.loginState){
          case ApplicationLoginState.loggedIn:
            return HomeScreen(UniqueKey());
          case ApplicationLoginState.loggedOut:
            return LoginScreen();
          default:
            return LandingScreen();
        }
      }
    );
  }
}
