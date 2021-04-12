import 'package:flutter/material.dart';
import 'package:flutter_app/models/models.dart';
import 'package:flutter_app/services/repository.dart';
import 'package:provider/provider.dart';

class Detail extends StatefulWidget {
  //Object to handle view
  final Exercise exercise;

  Detail({required this.exercise});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  String? _downloadUrl;

  @override
  void initState() {
    super.initState();

    String? imageName = widget.exercise.imageName;
    if (imageName == null) {
      return;
    }

    context.read<Repository>().getDownloadUrl(imageName).then((value) {
      setState(() {
        _downloadUrl = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String image = 'images/push-ups.jpg';
    if (_downloadUrl != null && _downloadUrl != "") {
      image = _downloadUrl!;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.exercise.name!),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Image.asset(image, fit: BoxFit.fitWidth),
        ));
  }
}
