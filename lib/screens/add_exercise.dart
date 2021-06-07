import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/exercise.dart';
import 'package:flutter_app/services/database.dart';

class AddExercise extends StatelessWidget {
  String? _name;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add your Exersize'),
      ),
      body: Column(
        children: [
          Form(
              child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.fitness_center),
                  hintText: 'Give a good name',
                  labelText: 'Name of Exercise',
                ),
                onSaved: (String? value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                  if (_formKey.currentState!.validate()){
                    _formKey.currentState!.save();
                  }
                  Database database = Database(FirebaseFirestore.instance);

                  database.addExercise(name: value);

                },
                validator: (String? value) {
                  return (value != null && value.contains('@'))
                      ? 'Do not use the @ char.'
                      : null;
                },
              )
              //TODO: Add image Upload
              //TODO: Add dropdown from options
            ],
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _formKey.currentState!.save();

        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
