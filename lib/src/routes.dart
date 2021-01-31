import 'package:flutter/material.dart';
import 'package:flutter_app/src/screens/home.dart';
import 'package:flutter_app/src/screens/journal.dart';

class RouteGenerator {
  static const String homePage = '/';
  static const String journalPage = '/journal';

  RouteGenerator._() {}

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(
          builder: (_) => HomePage(),
        );
      case journalPage:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      default:
        throw FormatException("Route not found");
    }
  }
}

class RouteException implements Exception {
  final String message;
  const RouteException(this.message);
}
