import 'package:flutter/material.dart';
import 'package:flutter_app/services/route_generator.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login or Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(100.0),
        child: Center(
          child: Column(children: [
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed(RouterGenerator.MailSignUpRoute);
                },
                icon: Icon(Icons.mail),
                label: Text('Register with E-Mail')),
            ElevatedButton.icon(
              onPressed: null,
              icon: Icon(Icons.android),
              label: Text('Register with Google'),
            ),
            Spacer(),
            Text('Already have an account?'),
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed(RouterGenerator.SignInRoute);
                },
                icon: Icon(Icons.login),
                label: Text('Login')),
          ]),
        ),
      ),
    );
  }
}
