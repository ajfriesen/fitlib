import 'package:flutter/material.dart';
import 'package:flutter_app/components/exercise/exercise_list_view.dart';
import 'package:flutter_app/models/exercise.dart';
import 'package:flutter_app/notifiers/exercise_notifier.dart';
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
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.pushNamed(context, "/sign-up");
            },
          )
        ],
      ),
      body: exerciseNotifier != null
          ? Container(
              color: Colors.black12,
              child: ListView.builder(
                  itemCount: _localList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.all(0),
                      key: ObjectKey(_localList[index]),
                      child: ExerciseListView(
                        exercise: _localList[index],
                      ),
                    );
                  }))
          : Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(RouterGenerator.exerciseAddRoute);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
