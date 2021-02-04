import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/test.dart';
import 'package:flutter_app/data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Center(
        child: Scaffold(
          appBar: AppBar(
            // leading: Icon(Icons.menu),
            title: Text('My App'),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Center(
                child: Container(
                  child: Text('Hello World'),
                ),
              ),
              MyStatelessWidget(),
              // MyList(),
              Expanded(
                child: MyList(),
              ),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              children: const <Widget>[
                DrawerHeader(
                  child: Text("Drawer Title"),
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("Settings"),
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text("About"),
                ),
              ],
            ),
          ),
          bottomNavigationBar: buildBottomNavigationBar(),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              MyStatelessWidget();
              // why does this not work?
            },
          ),
        ),
      ),
    );
  }
}
