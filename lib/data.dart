import 'package:flutter/material.dart';

class MyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        MyCard(),
        MyCard(),
        MyCard(),
        MyCard(),
        MyCard(),
        MyCard(),
        MyCard(),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Image.asset('images/push-ups.jpg'),
              title: Text('Push up'),
              // subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('Add to Favorite'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('Add to workout'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
