import 'package:flutter/material.dart';
import 'package:flutter_app/screens/add_exercise.dart';
import 'package:flutter_app/screens/detail.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/Exercise/add':
        return MaterialPageRoute(builder: (_) => AddExercise());
      case '/ExerciseDetailView':
        //Validate if of type Exercise
        // if (args is Exercise) {
        return MaterialPageRoute(builder: (_) {
          return Detail(
            exercise: args,
          );
        });
      // }
      // print(args);
      // return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
