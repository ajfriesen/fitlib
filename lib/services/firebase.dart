import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FlutterFireInit extends StatefulWidget {
  final Widget child;
  const FlutterFireInit({required Key key, required this.child}) : super(key: key);

  @override
  _FlutterFireInitState createState() => _FlutterFireInitState();
}

class _FlutterFireInitState extends State<FlutterFireInit> {
  late Future<FirebaseApp> _initialization;

  @override
  void initState() {
    _initialization = Firebase.initializeApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          // return SomethingWentWrong();
          print('Something went wrong in Flutter Fire');
        }

        //TODO: See what to do with this
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return widget.child;
        }

        // Otherwise, show something whilst waiting for initialization to complete
        //TODO: Change for splash just in case
        return Container();
      },
    );
  }
}
