import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toast_alert {

  void successToast(var text) {
    Fluttertoast.showToast(
        msg: text,
        // message
        toastLength: Toast.LENGTH_SHORT,
        // length
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        backgroundColor: Colors.green);
  }

  void errorToast(var text) {
    Fluttertoast.showToast(
        msg: text,
        // message
        toastLength: Toast.LENGTH_SHORT,
        // length
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        backgroundColor: Colors.red);
  }
}
