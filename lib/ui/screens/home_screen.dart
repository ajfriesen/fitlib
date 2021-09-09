import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/exercise.dart';
import 'package:flutter_app/notifiers/authentication_notifier.dart';
import 'package:flutter_app/notifiers/exercise_notifier.dart';
import 'package:flutter_app/services/authentication.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/services/route_generator.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen(Key key) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  @override
  void initState() {
    ExerciseNotifier exerciseNotifier = Provider.of<ExerciseNotifier>(context, listen: false);
    Database.getExercises(exerciseNotifier);
    AuthenticationNotifier authenticationNotifier = Provider.of<AuthenticationNotifier>(context, listen: false);
    authenticationNotifier.listenUserChange();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ExerciseNotifier exerciseNotifier = Provider.of<ExerciseNotifier>(context);
    List<Exercise> _localList = exerciseNotifier.getExerciseList();

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
                icon: Icon(Icons.account_circle),
                onPressed: () {
                  Navigator.pushNamed(context, "/sign-up");
                },
              );
            } else {
              return IconButton(
                icon: Icon(Icons.mail),
                onPressed: () {
                  Authentication.signOut();
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
            stream: Database.getExercises().asStream(),
            builder: (BuildContext context, AsyncSnapshot<List<Exercise>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(snapshot.data![index].name!),
                    );
                  },
                );
              }
              if (snapshot.hasError) {
                return Text("nope");
              }
              return Text("llllll");
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
