import 'package:flutter/material.dart';
import 'package:flutter_app/models/models.dart';
import 'package:flutter_app/services/camera.dart';

class Detail extends StatefulWidget {
  //Object to handle view
  final Exercise exercise;

  Detail({required this.exercise});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  static const String placeholderImage = 'images/placeholder.png';

  final media = Media();

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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          media.getMedia();
        },
        child: const Icon(Icons.add_photo_alternate),
        tooltip: 'Pick Image',
      ),
    );
  }
}
