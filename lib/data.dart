import 'package:flutter/material.dart';

class MyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        MyCard(),
        MyCard(),
      ],
    );
  }
}

class MyCard extends StatelessWidget {
  MyCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: ListTile(
          onTap: () {},
          leading: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Image.asset('images/push-ups.jpg'),
          ),
          title: Text('Push up'),
          trailing: Icon(Icons.more_vert),
        ),
      ),
    );
  }
}
