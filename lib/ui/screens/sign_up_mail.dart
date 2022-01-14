import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/ui/widget/error_dialog.dart';
import 'package:flutter_app/services/authentication.dart';

class MailSignUp extends StatefulWidget {
  const MailSignUp({Key? key}) : super(key: key);

  @override
  _MailSignUpState createState() => _MailSignUpState();
}

class _MailSignUpState extends State<MailSignUp> {
  final _formkey = GlobalKey<FormState>();
  String? email;
  String? password;

  final Authentication _auth = Authentication(firebaseAuth: FirebaseAuth.instance);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrieren'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Form(
            key: _formkey,
            child: Column(children: [
              TextFormField(
                decoration: const InputDecoration(
                    icon: Icon(Icons.mail), hintText: "mail@domain.com", labelText: "E-Mail"),
                onSaved: (String? value) {
                  email = value;
                },
                enableSuggestions: false,
                autocorrect: false,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                    icon: Icon(Icons.password_sharp),
                    hintText: "**********",
                    labelText: "Password"),
                enableSuggestions: false,
                autocorrect: false,
                onSaved: (String? value) {
                  password = value;
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter some text';
                  }
                  return null;
                },
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState!.save();
                      if (email != null && password != null) {
                        _auth.registerWithMail(email!, password!,
                            (error, title) => showErrorDialog(context, title, error));
                        User? currentUser = _auth.getUser();
                        if ( currentUser != null) {
                          Database.addUser(email: currentUser.email!, userId: currentUser.uid);
                        }

                      }
                    }
                  },
                  icon: Icon(Icons.send),
                  label: Text('Send'))
            ]),
          ),
        ),
      ),
    );
  }
}
