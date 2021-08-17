import 'package:flutter/material.dart';
import 'package:flutter_app/components/error_dialog.dart';
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
                        Authentication.registerWithMail(email!, password!,
                            (error, title) => showErrorDialog(context, title, error));
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
