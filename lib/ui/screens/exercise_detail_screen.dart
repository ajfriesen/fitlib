import 'package:flutter/material.dart';
import 'package:flutter_app/ui/widget/custom_image.dart';
import 'package:flutter_app/view_models/exercise_list_view_model.dart';
import 'package:flutter_app/models/exercise.dart';
import 'package:flutter_app/services/shared_preferences_service.dart';
import 'package:flutter_app/models/exercise_image_list.dart';

class Detail extends StatefulWidget {
  final Exercise exercise;

  Detail({required this.exercise});

  @override
  State createState() {
    //TODO: Why not return DetailState(exercise)?
    return DetailState();
  }
}

class DetailState extends State<Detail> {
  ExerciseListViewModel? exerciseViewModel;

  static const String placeholderImage = 'images/placeholder.png';
  final PreferencesService preferencesServiceService = PreferencesService();

  String? imagePath;

  List<CustomExerciseData> localImageDataList = List.empty();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(widget.exercise.name!),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      child: widget.exercise.imageUrl == "" || widget.exercise.imageUrl == null
                          ? Image.asset(placeholderImage, fit: BoxFit.fitWidth)
                          : Image.network(widget.exercise.imageUrl!, fit: BoxFit.fitWidth),
                    ),
                    SizedBox(height: 40),
                    Text(
                      "Description",
                      style: TextStyle(fontSize: 30),
                    ),
                    widget.exercise.description != null || widget.exercise.description != ""
                        ? Text(widget.exercise.description!)
                        : Text("Keine Beschreibung"),
                    const Divider(
                      height: 20,
                      thickness: 5,
                      indent: 0,
                      endIndent: 40,
                    ),
                    Text(
                      'My saved Images',
                      style: TextStyle(fontSize: 30),
                    ),
                    imagePath != null && imagePath != ''
                        ? CustomImage(imagePath: imagePath!)
                        : Text('No images yet'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
        child: const Icon(Icons.add_photo_alternate),
        tooltip: 'Pick Image',
      ),
    );
  }
}
