import 'package:flutter/material.dart';
import 'package:flutter_app/models/exercise.dart';
import 'package:flutter_app/screens/add_exercise.dart';
import 'package:flutter_app/screens/detail.dart';

class RouterGenerator {
  static const String exerciseAddRoute = '/Exercise/add';
  static const String exerciseDetailViewRoute = '/ExerciseDetailView';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case exerciseAddRoute:
        return MaterialPageRoute(builder: (_) => AddExercise());
      case exerciseDetailViewRoute:
        // check if args is actually of type Exercise and pass args to Detail()
        if (args is Exercise) {
          return MaterialPageRoute(
            builder: (_) => Detail(
              exercise: args,
            ),
          );
        }
        return _errorRoute();
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
