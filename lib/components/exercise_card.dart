import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/exercise.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/services/route_generator.dart';

class ExerciseCard extends StatefulWidget {
  @override
  _ExerciseCardState createState() => _ExerciseCardState();

  ExerciseCard(this.exercise);

  final Exercise exercise;
}

class _ExerciseCardState extends State<ExerciseCard> {
  // String imageurl = await firebaseRepositoy.getDownloadUrl(exercise.imageName!)

  static const String placeholder = "images/placeholder.png";
  String imageurl = "images/placeholder.png";
  bool fetched = false;

  @override
  void initState() {
    Database firebaseRepositoy = Database(FirebaseFirestore.instance);

    firebaseRepositoy.getDownloadUrl(widget.exercise.imageName!).then((value) {
      setState(() {
        imageurl = value;
        fetched = true;
        if (fetched == true) widget.exercise.imageUrl = imageurl;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.exercise.name!),
        leading: fetched && imageurl != placeholder
            ? Image.network(widget.exercise.imageUrl!)
            : Image.asset(imageurl),
        subtitle: Text(widget.exercise.imageName!),
        trailing: Icon(Icons.more_vert),
        onTap: () {
          Navigator.of(context).pushNamed(
              RouterGenerator.exerciseDetailViewRoute,
              arguments: widget.exercise);
        },
      ),
    );
  }
}
