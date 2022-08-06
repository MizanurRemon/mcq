import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/retry.dart';
import 'package:mcq/Toast/Toast_alert.dart';
import '../Model/Login/Login_response.dart';
import 'Constants.dart';
import 'package:dio/dio.dart';
//import '../Toast/Toast_alert.dart';

class Api_services {
  var dio = Dio();
  Toast_alert toast_alert = new Toast_alert();// with default Options

  Future<Login_response> loginUser(String phone, String password) async {
    //var dio = Dio();
    final response = await dio.post(Constants().BASE_URL + "/admin/admin_login",
        data: {'phone': phone, 'password': password});

    Login_response login_response = Login_response.fromJson(response.data);
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //Login_response login_response = data as Login_response;
      //login_response.message = jsonDecode(data);
      //successToast(login_response.data?.adminID.toString());
      if(login_response.status == 1){
        toast_alert.successToast(login_response.message);
      }else{
        toast_alert.errorToast(login_response.message);
      }
      return Login_response.fromJson(jsonDecode(response.data));
      //String responseString = response.body;
      //successToast(responseString);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      toast_alert.errorToast("error");
      throw Exception('Failed to create album.');
    }
  }
}
