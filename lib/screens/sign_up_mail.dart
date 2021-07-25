import 'package:flutter/material.dart';
import 'package:flutter_app/services/authentication.dart';

class MailSignUp extends StatefulWidget {
  const MailSignUp({Key? key}) : super(key: key);

  @override
  _MailSignUpState createState() => _MailSignUpState();
}

class _MailSignUpState extends State<MailSignUp> {
  final _formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login or Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(children: [
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.mail),
                hintText: "mail@domain.com",
                labelText: "E-Mail"
              )
            ),
            TextFormField(
                decoration: const InputDecoration(
                    icon: Icon(Icons.password_sharp),
                    hintText: "**********",
                    labelText: "Password"
                )
            ),
          ElevatedButton.icon(
              onPressed: () {

              },
              icon: Icon(Icons.send), label: Text('Send'))
          ]),
        ),
      ),
    );
  }
}
