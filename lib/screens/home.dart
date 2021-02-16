import 'package:flutter/material.dart';
import 'package:flutter_app/data.dart';
import 'package:flutter_app/models.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
    //return MyList();
    return MyList(exerciseList);
  }
}
