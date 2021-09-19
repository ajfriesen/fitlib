import 'package:flutter/material.dart';
import 'package:flutter_app/models/exercise.dart';
import 'package:flutter_app/notifiers/exercise_notifier.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/services/media_file_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddExercise extends StatefulWidget {

  Exercise? exercise;

  AddExercise(this.exercise);

  AddExercise.empty();

  @override
  _AddExerciseState createState() {
    return _AddExerciseState();
  }
}

class _AddExerciseState extends State<AddExercise> {
  final _formKey = GlobalKey<FormState>();
  Exercise exercise = Exercise.empty();
  final Media media = Media();
  PickedFile pickedFile = PickedFile("");

  // _showSnackBar(String text, BuildContext context) {
  //   final snackbar = SnackBar(content: Text(text));
  //   _scaffoldKey.currentState.showSnackBar(snackbar);
  // }

  @override
  void initState() {
    if (widget.exercise != null){
      exercise = widget.exercise!;
    }
    super.initState();
  }

  _createExerciseOnPressed(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      // _showSnackBar("Failed to create Post", context);
      return;
    }
    _formKey.currentState!.save();
    exercise.imageName = pickedFile.path;

    ExerciseNotifier exerciseNotifier = Provider.of(context, listen: false);
    exerciseNotifier.uploadExercise(exercise, pickedFile).then((value) {
      if (value != null) {}
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exercise?.id == null ? 'Add your Exercise' : 'Edit your Exercise'),
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: widget.exercise?.name,
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
                    onPressed: () {
                      media.chooseImagePicker(context).then((value) {
                        if (value != null || value != "") {
                          pickedFile = value!;
                        }
                      });
                    },
                    icon: const Icon(Icons.add_a_photo))
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _createExerciseOnPressed(context);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
