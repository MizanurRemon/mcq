import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mcq/API/Api_services.dart';
import 'package:mcq/Toast/Toast_alert.dart';

void main() {
  runApp(const LoginPage());
}

Toast_alert toast_alert = new Toast_alert();
var fullPadding = 10.0;

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
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
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(fullPadding),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 100,
                      child: const Center(
                        child: Text(
                          "MCQ",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'RaleWay'),
                        ),
                      ),
                    ),
                    Container(
                      height: screenHeight / 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Center(
                              child: Card(
                                child: Padding(
                                  padding: EdgeInsets.all(fullPadding),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: screenWidth,
                                        child: const Text(
                                          "Login Here",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextField(
                                        controller: phoneController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: "Enter phone",
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextField(
                                        controller: passwordController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: "Password",
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 40,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            //successToast("hi");
                                            var phone = phoneController.text
                                                .toString()
                                                .trim();
                                            var password = passwordController
                                                .text
                                                .toString()
                                                .trim();

                                            //successToast(phone+" "+password);
                                            if (phone == "" || password == "") {
                                              if (phone == "") {
                                                toast_alert.errorToast("empty phone");
                                              } else if (password == "") {
                                                toast_alert.errorToast("empty password");
                                              }
                                            } else {
                                              //successToast("hello");
                                              //Login_response response = Api_services().loginUser(phone, password) as Login_response;
                                              setState(() {
                                                Api_services()
                                                    .loginUser(phone, password);
                                              });
                                            }
                                          },
                                          child: Text(
                                            "Sign In",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.amber,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
