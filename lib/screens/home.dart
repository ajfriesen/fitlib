import 'package:flutter/material.dart';
import 'package:flutter_app/components/exercise_list.dart';
import 'package:flutter_app/models/exercise.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool firstRender = true;

  List<Exercise> exerciseList = [];

  @override
  Widget build(BuildContext context) {
    return MyList();
  }
}
