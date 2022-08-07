import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mcq/API/Api_services.dart';
import 'package:mcq/Toast/Toast_alert.dart';

Toast_alert toastAlert = Toast_alert();
var fullPadding = 10.0;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginStateState();
}

class _LoginStateState extends State<LoginPage> {
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
                    const SizedBox(
                      height: 100,
                      child: Center(
                        child: Text(
                          "MCQ",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'RaleWay'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight / 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(fullPadding),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: screenWidth,
                                      child: const Text(
                                        "Login Here",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                      controller: phoneController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "Enter phone",
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                      controller: passwordController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "Password",
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 40,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          //successToast("hi");
                                          var phone = phoneController.text
                                              .toString()
                                              .trim();
                                          var password = passwordController.text
                                              .toString()
                                              .trim();

                                          //successToast(phone+" "+password);
                                          if (phone == "" || password == "") {
                                            if (phone == "") {
                                              toastAlert
                                                  .errorToast("empty phone");
                                            } else if (password == "") {
                                              toastAlert
                                                  .errorToast("empty password");
                                            }
                                          } else {
                                            //successToast("hello");
                                            //Login_response response = Api_services().loginUser(phone, password) as Login_response;
                                            setState(() {
                                              ApiServices()
                                                  .loginUser(phone, password);
                                            });
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.amber,
                                        ),
                                        child: const Text(
                                          "Sign In",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    )
                                  ],
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
