import 'package:flutter/material.dart';
import 'package:flutter_app/src/routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_app/src/providers/entry_provider.dart';
import 'package:flutter_app/src/screens/home.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EntryProvider(),
      child: MaterialApp(
        home: HomePage(),
        theme: ThemeData(),
        initialRoute: RouteGenerator.homePage,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
