import 'dart:convert';
import 'package:mcq/Toast/Toast_alert.dart';
import '../Model/Login/Login_response.dart';
import 'Constants.dart';
import 'package:dio/dio.dart';

class ApiServices {

  Toast_alert toastAlert = Toast_alert(); // with default Options

  Future<Login_response> loginUser(String phone, String password) async {
    //var dio = Dio();
    var dio = Dio();
    final response = await dio.post("${Constants().BASE_URL}/admin/admin_login",
        data: json.encode({'phone': phone, 'password': password}));

    Login_response loginResponse = Login_response.fromJson(response.data);
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      //Login_response login_response = data as Login_response;
      //login_response.message = jsonDecode(data);
      //successToast(login_response.data?.adminID.toString());
      if (loginResponse.status == 1) {
        toastAlert.successToast(loginResponse.message);

        Map<String, dynamic> data = new Map<String, dynamic>.from(json.decode(response.data));

        print(data['message `']);
      } else {
        toastAlert.errorToast(loginResponse.message);
      }


      return Login_response.fromJson(json.decode(response.data));
      //String responseString = response.body;
      //successToast(responseString);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      toastAlert.errorToast("error");
      throw Exception('Failed to create album.');
    }
  }
}
