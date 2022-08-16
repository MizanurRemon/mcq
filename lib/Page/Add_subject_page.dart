import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mcq/API/Api_services.dart';
import 'package:mcq/Model/Common/Common_response.dart';
import 'package:mcq/Toast/Toast_alert.dart';
import 'package:intl/intl.dart';

Toast_alert toast_alert = Toast_alert();

class Add_subject_page extends StatefulWidget {
  const Add_subject_page({Key? key}) : super(key: key);

  @override
  State<Add_subject_page> createState() => _Add_subject_pageState();
}

getCurrentDate() {
  return DateFormat('yyyy-MM-dd hh:mm').format(DateTime.now());
}

class _Add_subject_pageState extends State<Add_subject_page> {
  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Add Subject",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: screenWidth,
                    child: TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                          hintText: "Title", border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: screenWidth,
                    height: 40,
                    child: Padding(
                      padding: EdgeInsets.all(0.0),
                      child: ElevatedButton(
                        onPressed: () {
                          var title = titleController.text.toString().trim();

                          var formatter = DateFormat('yyyy-MM-dd hh:mm a')
                              .format(DateTime.now());

                          if (title == "") {
                            toast_alert.errorToast("empty value");
                          } else {
                            //toast_alert.successToast(formatter);
                            setState(() {
                              CommonResponse commonResponse;
                              ApiServices().addSubject(title).then((value) {
                                CommonResponse response =
                                    CommonResponse.fromJson(value);

                                if (response.status == 1) {
                                  toast_alert.successToast(response.message);
                                } else {
                                  toast_alert.errorToast(response.message);
                                }
                              });
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.amber,
                        ),
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
