import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/exercise.dart';
import 'package:flutter_app/notifiers/authentication_notifier.dart';
import 'package:flutter_app/services/authentication.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/services/route_generator.dart';
import 'package:flutter_app/ui/widget/exercise_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen(Key key) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  // @override
  // void initState() {
  //   // AuthenticationNotifier authenticationNotifier =
  //   //     Provider.of<AuthenticationNotifier>(context, listen: false);
  //   // authenticationNotifier.getLoginState();
  //   super.initState();
  // }

  final Authentication _auth = Authentication(firebaseAuth: FirebaseAuth.instance);

  Stream<List<Exercise>> _exerciseStream = Database.getExercisesWithUpdates();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FitLib"),
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.account_circle),
          //   onPressed: () {
          //     Navigator.pushNamed(context, "/sign-up");
          //   },
          // ),
          Consumer<AuthenticationNotifier>(
            builder: (context, appState, _) {
              if (appState.loginState == ApplicationLoginState.loggedOut) {
                return IconButton(
                  icon: Icon(Icons.login),
                  onPressed: () {
                    Navigator.pushNamed(context, "/sign-up");
                  },
                );
              } else {
                return IconButton(
                  icon: Icon(Icons.account_circle),
                  onPressed: () {
                    _auth.signOut();
                    Navigator.pushReplacementNamed(context , '/');
                  },
                );
              }
            },
          ),
        ],
      ),
      body: Container(
          color: Colors.black12,
          child: StreamBuilder(
            stream: _exerciseStream,
            builder: (BuildContext context, AsyncSnapshot<List<Exercise>> snapshot) {
              debugPrint('Debug stream');
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  print('none');
                  return Dialog(child: Row(children: [CircularProgressIndicator(),],),);
                case ConnectionState.waiting:
                  print('waiting');
                  return Dialog(child: Row(children: [CircularProgressIndicator(),],),);
                case ConnectionState.active:
                  if (snapshot.hasData && snapshot.data != null) {
                    return ExerciseList(
                      exercises: snapshot.data!,
                      itemcCount: snapshot.data!.length,
                    );
                  }
                  if (snapshot.hasError) {
                    return Text("nope");
                  }
                  return Container();
                case ConnectionState.done:
              }
              return Container();
            },
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(RouterGenerator.exerciseAddRoute);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
