import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/models.dart';
import 'package:flutter_app/screens/detail.dart';
import 'package:flutter_app/services/database.dart';

class ExerciseCard extends StatefulWidget {
  @override
  _ExerciseCardState createState() => _ExerciseCardState();

  ExerciseCard(this.exercise);

  final Exercise exercise;
}

class _ExerciseCardState extends State<ExerciseCard> {
  // String imageurl = await firebaseRepositoy.getDownloadUrl(exercise.imageName!)

  String imageurl = "images/push-ups.jpg";
  bool fetched = false;

  @override
  void initState() {
    Database firebaseRepositoy = Database(FirebaseFirestore.instance);

    firebaseRepositoy.getDownloadUrl(widget.exercise.imageName!).then((value) {
      setState(() {
        imageurl = value;
        fetched = true;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.exercise.name!),
        leading: fetched ? Image.network(imageurl) : Image.asset(imageurl),
        subtitle: Text(widget.exercise.imageName!),
        trailing: Icon(Icons.more_vert),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Detail(exercise: widget.exercise)),
        ),
      ),
    );
  }
}
