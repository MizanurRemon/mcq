import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mcq/Sessions/Session_management.dart';
import 'package:mcq/Toast/Toast_alert.dart';

Toast_alert toast_alert = Toast_alert();
Session_management session_management = Session_management();
var userID;

class Home_Page extends StatefulWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  @override
  void initState() {
    super.initState();

    getSession();

    //userID = await session_management.getUserID();
    //     toast_alert.successToast(userID);
  }

  getSession() async {
    userID = await session_management.getUserID();
    toast_alert.successToast(userID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "MCQ",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
