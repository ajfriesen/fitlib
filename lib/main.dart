import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

import 'components/exercise/exercise_view_model.dart';
import 'notifiers/exercise_notifier.dart';

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
        create: (context) => ExerciseNotifier(),
      ),
    ],
    child: MyApp(),
  )
      );
}

class MyApp extends StatefulWidget {
  @override
  State createState() =>  MyAppState();
}


class MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(UniqueKey()),
      routes: {
        // "/add_post": (context) => AddPostScreen(),
      },
    );
  }
}
  // Widget build(BuildContext context) {
  //           return MaterialApp(
  //               title: 'Flutter Demo',
  //               theme: ThemeData(
  //                 primarySwatch: Colors.blue,
  //                 visualDensity: VisualDensity.adaptivePlatformDensity,
  //               ),
  //               home: ChangeNotifierProvider(
  //                 create: (context) => ExerciseViewModel(),
  //                 child: ExerciseListPage(),
  //               ));
  //         }retur



//   return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: ChangeNotifierProvider(
//         create: (context) => ExerciseViewModel(),
//         child: ExerciseListPage(),
//       ));
// }
// }

// class MyApp extends StatelessWidget {
//   static const String _title = 'Flutter Code Sample';
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//         providers: [
//           Provider<Database>(
//             create: (_) {
//               return Database(FirebaseFirestore.instance, FirebaseStorage.instance);
//             },
//           ),
//           Provider<Login>(
//             create: (_) => Login(FirebaseAuth.instance),
//           ),
//           // StreamProvider(
//           //   create: (context) => context.read<Login>(),
//           // ),
//         ],
//         child: MaterialApp(
//           title: _title,
//           home: MyStatefulWidget(),
//           onGenerateRoute: RouterGenerator.generateRoute,
//         ));
//   }
// }
//
// class MyStatefulWidget extends StatefulWidget {
//   MyStatefulWidget({Key? key}) : super(key: key);
//
//   @override
//   _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
// }
//
// class _MyStatefulWidgetState extends State<MyStatefulWidget> {
//   @override
//   void initState() {
//     // 1 - Moved Firebase initialization from here.
//
//     Login firebaseAuth = Login(FirebaseAuth.instance);
//     firebaseAuth.anonymousLogin();
//     super.initState();
//   }
//
//   int _selectedIndex = 0;
//   static List<Widget> _widgetOptions = <Widget>[
//     Home(),
//     WorkoutList(),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('FitLib'),
//         actions: <Widget>[
//           IconButton(
//             icon: const Icon(Icons.account_circle),
//             onPressed: () {
//               Navigator.of(context).pushNamed(RouterGenerator.signUpViewRoute);
//             },
//           )
//         ],
//       ),
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.fitness_center),
//             label: 'Exercise',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.list),
//             label: 'Workouts',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.amber[800],
//         onTap: _onItemTapped,
//       ),
//       drawer: Drawer(),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.of(context).pushNamed(RouterGenerator.exerciseAddRoute);
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
