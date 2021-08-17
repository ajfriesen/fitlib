import 'package:flutter/material.dart';
import 'package:flutter_app/components/error_dialog.dart';
import 'package:flutter_app/services/authentication.dart';
import 'package:flutter_app/services/route_generator.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  String? password;
  String? email;
  String? errorMessage;

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
                          icon: Icon(Icons.password_sharp), hintText: "**********", labelText: "Password"),
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
                          Authentication.loginWithMail(email: email!, password: password!,  errorCallback: (error, title) => showErrorDialog(context, title, error));
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
