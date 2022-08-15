import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mcq/API/Api_services.dart';
import 'package:mcq/Model/Job.dart';
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
  //SubjectResponse subjectList = SubjectResponse();

  @override
  void initState() {
    super.initState();

    getSession().then((value) {});

    ApiServices().getSubjectList();
    //get_data();
  }

  Future<List<Job>> fetchJobs() async {
    final jobsListAPIUrl = 'https://mock-json-service.glitch.me/';
    final response = await dio.get(jobsListAPIUrl);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.data);
      return jsonResponse.map((job) => new Job.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  getSession() async {
    userID = await session_management.getUserID();

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

  get_data() async {
    ApiServices().getSubjectList2().then((value) {
      SubjectResponse response = SubjectResponse.fromJson(value);

      print("Loaded Data: " + response.toString());

      return response;
    });
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
                  child: FutureBuilder<List<Data>>(
                    future: ApiServices().getSubjectList(),
                    builder: (context,  snapshot) {
                      if (snapshot.hasData) {
                        List<Data>? data = snapshot.data as List<Data>;

                        return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Text(data[index].subTitle.toString());
                            });
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                  /*child: FutureBuilder<List<Job>>(
                    future: ApiServices().fetchJobs(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Job> data = snapshot.data as List<Job>;
                        return _jobsListView(data);
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return CircularProgressIndicator();
                    },
                  ),*/
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
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/add_subject_page', (Route<dynamic> route) => true);
          },
          backgroundColor: Colors.blueGrey,
          child: const Icon(Icons.add),
        ),
      ),
      drawer: const NavigationDrawer(),
    );
  }
}

ListView _jobsListView(data) {
  return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Text(data[index].position,
            semanticsLabel: data[index].company.toString());
      });
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
