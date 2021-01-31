import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/models/entry.dart';
import 'package:flutter_app/src/providers/entry_provider.dart';
import 'package:flutter_app/src/screens/entry.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<EntryProvider>(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Journal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Übungen',
          ),
        ],
      ),
      appBar: AppBar(
        title: Text('My Journal'),
      ),
      body: Text("Hi!"),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
