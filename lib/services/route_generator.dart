import 'package:flutter/material.dart';
import 'package:flutter_app/models/exercise.dart';
import 'package:flutter_app/ui/screens/add_exercise_screen.dart';
import 'package:flutter_app/ui/screens/exercise_detail_screen.dart';
import 'package:flutter_app/ui/screens/home_screen.dart';
import 'package:flutter_app/ui/screens/login_screen.dart';
import 'package:flutter_app/ui/screens/sign_up_mail.dart';
import 'package:flutter_app/ui/screens/sign_up_screen.dart';

class RouterGenerator {
  static const String exerciseListView = '/';
  static const String exerciseAddRoute = '/Exercise/add';
  static const String exerciseDetailViewRoute = '/ExerciseDetailView';
  static const String signUpViewRoute = '/sign-up';
  static const String MailSignUpRoute = '/sign-up/mail';
  static const String SignInRoute = '/sign-in';

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
      case signUpViewRoute:
        return MaterialPageRoute(builder: (_) => SignUp());
      case MailSignUpRoute:
        return MaterialPageRoute(builder: (_) => MailSignUp());
      case SignInRoute:
        return MaterialPageRoute(builder: (_) => Login());
      case exerciseListView:
        return MaterialPageRoute(builder: (_) => HomeScreen(UniqueKey()));
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
