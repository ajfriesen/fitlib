import 'package:flutter/material.dart';
import 'package:flutter_app/models/models.dart';

class Detail extends StatefulWidget {
  //Object to handle view
  final Exercise exercise;

  Detail({required this.exercise});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.exercise.name!),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Image.network(widget.exercise.imageUrl!, fit: BoxFit.fitWidth),
        ));
  }
}
