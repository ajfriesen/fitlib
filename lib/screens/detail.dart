import 'package:flutter/material.dart';
import 'package:flutter_app/models/models.dart';

class Detail extends StatelessWidget {
  //Object to handle view
  final Exercise exercise;

  Detail({required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(exercise.name!),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Image.asset('images/push-ups.jpg', fit: BoxFit.fitWidth),
        ));
  }
}
