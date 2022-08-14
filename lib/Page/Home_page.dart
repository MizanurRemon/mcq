import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mcq/API/Api_services.dart';
import 'package:mcq/Sessions/Session_management.dart';
import 'package:mcq/Toast/Toast_alert.dart';
import 'package:mcq/Utils/Constants.dart';
import '../Model/Subject/Subject_response.dart';
import '../Model/Subject/Data.dart';

Toast_alert toast_alert = Toast_alert();
Session_management session_management = Session_management();
var userID;
Constants constants = Constants();
List<String> nameData = [];

class Home_Page extends StatefulWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  SubjectResponse subjectList = SubjectResponse();

  @override
  void initState() {
    super.initState();

    getSession().then((value) {});

    print(subjectList.toString());
  }

  getSession() async {
    userID = await session_management.getUserID();

    //get_data();
    return;
  }

  Future<List<String>> getData() async {
    nameData.add("name");
    nameData.add("name");
    nameData.add("name");
    // DEBUG
    await Future.delayed(const Duration(seconds: 2), () {});
    return nameData;
  }

  Future<List<String>> get_data() async {
    ApiServices().getSubjectList().then((value) {
      SubjectResponse response = SubjectResponse.fromJson(value);
      //toast_alert.successToast(response.status.toString());
      List<Data> data = response.data!;

      //print(response.data.toString());
      //List<String> nameData = [];
      for (var i = 0; i < data.length; i++) {
        //print(data[i].subTitle.toString());
        //getData(data[i].subTitle.toString());
        nameData.add(data[i].subTitle.toString());

        //toast_alert.successToast(nameData[i].toString());
      }

      //Future.delayed(const Duration(seconds: 2), () {});
      print("size " + nameData.length.toString());
      //print(data[1].subTitle.toString());
      //return nameData;
    });

    return nameData;
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "MCQ",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(constants.inPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: screenWidth,
                  child: const Text(
                    "Subject List",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: screenHeight,
                  child: FutureBuilder(
                      future: get_data(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          //toast_alert.successToast(snapshot.data.length.toString());

                          // var list = json.decode(snapshot.data.toString());

                          return ListView.builder(
                              itemCount: 5,
                              itemBuilder: (context, int index) {
                                return Container(
                                  child: Card(
                                    child: Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child: Text(
                                        "hello", //data![index].toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        } else {
                          toast_alert.errorToast("data not found");
                          return Container(
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.all(10.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(
                '/add_subject_page',
                    (Route<dynamic>
                route) =>
                true);
          },
          backgroundColor: Colors.blueGrey,
          child: const Icon(Icons.add),
        ),
      ),
      drawer: const NavigationDrawer(),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      );

  buildHeader(BuildContext context) => Container(
        color: Colors.yellow,
        height: 200,
        child: Padding(
          padding: EdgeInsets.all(constants.inPadding),
          child: const Center(
            child: Text(
              "MCQ",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );

  buildMenuItems(BuildContext context) => Column(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Profile"),
            onTap: () {
              Navigator.pop(context);
              toast_alert.successToast("Profile");
            },
          ),
          const Divider(
            color: Colors.black,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Log Out"),
            onTap: () {
              Navigator.pop(context);
              //toast_alert.successToast("log out");
              session_management.removeUser();

              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/login_page', (Route<dynamic> route) => false);
            },
          )
        ],
      );
}
