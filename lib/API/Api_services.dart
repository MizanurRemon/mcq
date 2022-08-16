import 'dart:convert';
import 'package:mcq/Model/Subject/Data.dart';
import 'package:mcq/Page/Home_page.dart';
import 'package:mcq/Toast/Toast_alert.dart';
import '../Model/Job.dart';
import '../Model/Subject/Subject_response.dart';
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

  Future<List<Data>> getSubjectList() async {
    final response =
        await dio.post("${Constants().BASE_URL}/admin/get_subject");

    //print(response.toString());

    if (response.statusCode == 200) {
      List jsonResponse = response.data['data'];
      //print("data$jsonResponse");
      return jsonResponse.map((data) => Data.fromJson(data)).toList();
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      //toastAlert.errorToast("error");
      print('Failed to load jobs from API');
      throw Exception('Failed to load jobs from API');
    }
  }

  Future<Map<String, dynamic>> addSubject(String title) async {
    //var dio = Dio();

    final response = await dio.post("${Constants().BASE_URL}/admin/add_subject",
        data: json.encode({'sub_title': title}));

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

  Future<Map<String, dynamic>> updateSubject(
      String subjectID, String title) async {
    //var dio = Dio();

    final response = await dio.post(
        "${Constants().BASE_URL}/admin/update_subject",
        data: json.encode({'subjectID': subjectID, 'sub_title': title}));

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
}
