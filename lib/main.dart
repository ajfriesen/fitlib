import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/workout_list.dart';
import 'package:flutter_app/services/authentication.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/services/route_generator.dart';
import 'package:provider/provider.dart';

import 'screens/home.dart';

void main() async {
  // 2 - Moved Firebase initialization to here
  // WidgetsFlutterBinding.ensureInitialized() is used to interact with the
  // Flutter engine. Firebase initialization needs to call native (Android) code
  // so this line of code ensures a communication channel to native.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
        create: (context) => Login(FirebaseAuth.instance),
        builder: (context, _) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<Database>(
            create: (_) {
              return Database(
                  FirebaseFirestore.instance, FirebaseStorage.instance);
            },
          ),
          Provider<Login>(
            create: (_) => Login(FirebaseAuth.instance),
          ),
          // StreamProvider(
          //   create: (context) => context.read<Login>(),
          // ),
        ],
        child: MaterialApp(
          title: _title,
          home: MyStatefulWidget(),
          onGenerateRoute: RouterGenerator.generateRoute,
        ));
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key? key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  void initState() {
    // 1 - Moved Firebase initialization from here.

    Login firebaseAuth = Login(FirebaseAuth.instance);
    firebaseAuth.anonymousLogin();
    super.initState();
  }

  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    WorkoutList(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FitLib'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.login),
            onPressed: () {
              Navigator.of(context).pushNamed(RouterGenerator.signUpViewRoute);
            },
          )
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Exercise',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Workouts',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(RouterGenerator.exerciseAddRoute);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
