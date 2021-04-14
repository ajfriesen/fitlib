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
  static const String placeholderImage = 'images/placeholder.png';

  @override
  Widget build(BuildContext context) {
    String imageurl = widget.exercise.imageUrl ?? placeholderImage;

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.exercise.name!),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: imageurl == placeholderImage || imageurl.isEmpty
              ? Image.asset(placeholderImage, fit: BoxFit.fitWidth)
              : Image.network(imageurl, fit: BoxFit.fitWidth),
        ));
  }
}
