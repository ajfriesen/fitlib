import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: Expanded(
                      child: Text('Push Up'),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Image.asset('images/push-ups.jpg',
                        fit: BoxFit.fitWidth),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Container(
                child: Text('Darauf achten'),
                padding: EdgeInsets.all(20.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
