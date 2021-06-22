import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/exercise.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/services/media_file_service.dart';
import 'package:image_picker/image_picker.dart';

class AddExercise extends StatefulWidget {
  @override
  _AddExerciseState createState() {
    return _AddExerciseState();
  }
}

class _AddExerciseState extends State<AddExercise> {
  final _formKey = GlobalKey<FormState>();
  final Database database = Database(FirebaseFirestore.instance,FirebaseStorage.instance);
  final Exercise exercise = Exercise.empty();
  final Media media = Media();
  PickedFile pickedFile = PickedFile("");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add your Exercise'),
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.fitness_center),
                    hintText: 'Give a good name',
                    labelText: 'Name of Exercise',
                  ),
                  onSaved: (String? value) {
                    exercise.name = value;

                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.fitness_center),
                    hintText: 'Exercise Description',
                    labelText: 'Exercise Description',
                  ),
                  onSaved: (String? value) {
                    exercise.description = value;
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter some text';
                    }
                    return null;
                  },
                ),
                IconButton(
                    onPressed: (){

                      media.chooseImagePicker(context).then((value) {
                        if (value != null || value != "") {
                          pickedFile = value!;
                        }
                      });
                      },
                    icon: const Icon(Icons.add_a_photo)
                    )
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            database.addExercise(
                name: exercise.name,
                description: exercise.description,
                imageName: pickedFile.path,
                imageUrl: "push-ups.jpg");
            if (pickedFile != "" || pickedFile != null) {
              database.uploadFile(pickedFile, exercise.name!);
            }
            Navigator.of(context).pop();
          }

        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
