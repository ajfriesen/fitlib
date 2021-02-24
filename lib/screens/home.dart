import 'package:flutter/material.dart';
import 'file:///C:/Users/andre/AndroidStudioProjects/flutter_app/lib/components/exercise_list.dart';
import 'file:///C:/Users/andre/AndroidStudioProjects/flutter_app/lib/models/models.dart';
import 'package:flutter_app/services/exercise_service.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool firstRender = true;

  List<Exercise> exerciseList = [];

  @override
  void initState() {
    // fetch data from firebase
    // transform data into exercises
    // put exersizes into the list
    // call build method to refresh the widets data (set state)
    // super.....
  }

  @override
  Widget build(BuildContext context) {
    if (firstRender) {
      firstRender = false;
      ExerciseService.getGlobalExerciseList().then((List) {
        setState(() {
          firstRender = false;
        });
      });
    }

    //return MyList();
    return MyList(exerciseList);
  }
}
