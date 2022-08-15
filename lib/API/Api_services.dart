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

    print(response.toString());

    if (response.statusCode == 200) {
      //List<Data> dataResponse = json.decode(response.data);

      List jsonResponse = json.decode(response.data);
      return jsonResponse.map<Data>((job) => new Data.fromJson(job)).toList();

      //return jsonResponse;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      //toastAlert.errorToast("error");
      print('Failed to load jobs from API');
      throw Exception('Failed to load jobs from API');
    }
  }

  Future<Map<String, dynamic>> getSubjectList2() async {
    final response =
        await dio.post("${Constants().BASE_URL}/admin/get_subject");

    if (response.statusCode == 200) {
      Map<String, dynamic> data = Map<String, dynamic>.from(response.data);

      //print(data['data'].toString());

      var dataList = data['data'];
      print(data.toString());

      return data;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      //toastAlert.errorToast("error");
      throw Exception('Failed to create album.');
    }
  }

  Future<List<Job>> fetchJobs() async {
    final jobsListAPIUrl = 'https://mock-json-service.glitch.me/';
    final response = await dio.get(jobsListAPIUrl);

    if (response.statusCode == 200) {
      //List jsonResponse = json.decode(response.data);
      //return jsonResponse.map<Job>((job) => new Job.fromJson(job)).toList();
      var data = json.decode(response.data);

      print(data.toString());

      List<Job> itemList = [];
      data.map((item) {
        itemList.add(Job.fromJson(item));
      }).toList();
      return itemList;
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}
