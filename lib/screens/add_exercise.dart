import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/exercise.dart';
import 'package:flutter_app/screens/detail.dart';
import 'package:flutter_app/services/database.dart';

class AddExercise extends StatefulWidget {
  @override
  _AddExerciseState createState() {
    return _AddExerciseState();
  }
}

class _AddExerciseState extends State<AddExercise> {
  final _formKey = GlobalKey<FormState>();

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
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                    Database database = Database(FirebaseFirestore.instance);

                    database.addExercise(
                        name: value,
                        imageName: "something",
                        imageUrl: "push-ups.jpg");
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter some text';
                    }
                    return null;
                  },
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
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
