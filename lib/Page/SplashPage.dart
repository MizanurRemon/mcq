import 'dart:async';
import 'package:flutter/material.dart';
import '../Sessions/Session_management.dart';
import '../Toast/Toast_alert.dart';
import 'Home_page.dart';

Toast_alert toastAlert = Toast_alert();
Session_management session_management = Session_management();
var fullPadding = 10.0;


class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            "MCQ FLUTTER",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), checkSession);

    //checkSession();
  }

  checkSession() async {
    final userID = await session_management.getUserID();
    //toast_alert.successToast(userID);
    //toast_alert.successToast("splash");
    if (userID != null) {
      //toast_alert.successToast(userID);
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/home_page', (Route<dynamic> route) => false);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/login_page', (Route<dynamic> route) => false);
    }
  }
}
