import 'dart:convert';
import 'package:mcq/Toast/Toast_alert.dart';
import '../Model/Login/Login_response.dart';
import '../Utils/Constants.dart';
import 'package:dio/dio.dart';

var dio = Dio();

class ApiServices {
  //Toast_alert toastAlert = Toast_alert(); // with default Options

  Future<Map<String, dynamic>> loginUser(String phone, String password) async {
    //var dio = Dio();

    final response = await dio.post("${Constants().BASE_URL}/admin/admin_login",
        data: json.encode({'phone': phone, 'password': password}));

    //Login_response loginResponse = Login_response.fromJson(response.data);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = Map<String, dynamic>.from(response.data);

      return data;
      //String responseString = response.body;
      //successToast(responseString);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      //toastAlert.errorToast("error");
      throw Exception('Failed to create album.');
    }
  }

  Future<Map<String, dynamic>> getSubjectList(String userID) async {
    final response =
        await dio.post("${Constants().BASE_URL}/admin/get_subject");

    if (response.statusCode == 200) {
      Map<String, dynamic> data = Map<String, dynamic>.from(response.data);

      return data;
      //String responseString = response.body;
      //successToast(responseString);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      //toastAlert.errorToast("error");
      throw Exception('Failed to create album.');
    }
  }
}
