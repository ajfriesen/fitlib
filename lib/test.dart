import 'package:flutter/material.dart';

class MyPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('A SnackBar has been shown.'),
          ),
        );
      },
      child: Text('Show SnackBar'),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('A SnackBar has been shown.'),
          ),
        );
      },
      child: Text('Show SnackBar'),
    );
  }
}

BottomNavigationBar buildBottomNavigationBar() {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.fitness_center),
        label: 'Exersice',
      ),
      // BottomNavigationBarItem(
      //   icon: Icon(Icons.favorite),
      //   label: 'Favorites',
      // ),
      // BottomNavigationBarItem(
      //   icon: Icon(Icons.person),
      //   label: 'My Stuff',
      // ),
      // BottomNavigationBarItem(
      //   icon: Icon(Icons.history),
      //   label: 'Tracker',
      // ),
      BottomNavigationBarItem(
        icon: Icon(Icons.list),
        label: 'Workouts',
      ),
    ],
    currentIndex: 0,
  );
}
