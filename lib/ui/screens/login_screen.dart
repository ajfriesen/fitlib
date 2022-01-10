import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/widget/error_dialog.dart';
import 'package:flutter_app/services/authentication.dart';
import 'package:flutter_app/services/route_generator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  String? password;
  String? email;
  String? errorMessage;

  final Authentication _auth = Authentication(firebaseAuth: FirebaseAuth.instance);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(100.0),
        child: Center(
          child: Column(children: [
            Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.mail),
                        hintText: "Mail",
                        labelText: "E-Mail",
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter some text';
                        }
                        return null;
                      },
                      onSaved: (String? value) {
                        email = value;
                      },
                      enableSuggestions: false,
                      autocorrect: false,
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
                    ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          _formkey.currentState!.save();
                          _auth.loginWithMail(
                              email: email!,
                              password: password!,
                              errorCallback: (error, title) =>
                                  showErrorDialog(context, title, error));
                          // Navigator.pop(context, "/");
                        }
                      },
                    ),
                  ],
                )),
            Spacer(),
            Text('Oder nutze social Logins'),
            ElevatedButton.icon(
                onPressed: null, icon: Icon(Icons.android), label: Text('Login with Google')),
            Spacer(),
            Text('Du hast keinen Account? Hier regeistrieren.'),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pushNamed(RouterGenerator.MailSignUpRoute);
              },
              icon: Icon(Icons.login),
              label: Text('Registrieren'),
            ),
          ]),
        ),
      ),
    );
  }
}
