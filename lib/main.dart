import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/notifiers/authentication_notifier.dart';
import 'package:flutter_app/services/route_generator.dart';
import 'package:flutter_app/ui/screens/home_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // 2 - Moved Firebase initialization to here
  // WidgetsFlutterBinding.ensureInitialized() is used to interact with the
  // Flutter engine. Firebase initialization needs to call native (Android) code
  // so this line of code ensures a communication channel to native.
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => AuthenticationNotifier()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitLib',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.grey[200],
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(UniqueKey()),
      onGenerateRoute: RouterGenerator.generateRoute,
      // routes: {
      // "/add_post": (context) => AddPostScreen(),
      // },
    );
  }
}
