
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Login",
        home: Scaffold(
            appBar: AppBar(
              title: Text('Login to formularium'),
            ),
            body: Center(
                child: Text('Hello World')
            )
        ));
  }
}