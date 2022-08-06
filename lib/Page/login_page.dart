import 'package:flutter/material.dart';

void main() {
  runApp(const LoginPage());
}

var fullPadding = 10.0;

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: LoginState(),
        ),
      ),
    );
  }
}

class LoginState extends StatefulWidget {
  const LoginState({Key? key}) : super(key: key);

  @override
  State<LoginState> createState() => _LoginStateState();
}

class _LoginStateState extends State<LoginState> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(fullPadding),

          ),
        ),
      ),
    );
  }
}
