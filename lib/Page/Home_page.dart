import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mcq/API/Api_services.dart';
import 'package:mcq/Model/Subject/Subject_response.dart';
import 'package:mcq/Sessions/Session_management.dart';
import 'package:mcq/Toast/Toast_alert.dart';
import 'package:mcq/Utils/Constants.dart';

Toast_alert toast_alert = Toast_alert();
Session_management session_management = Session_management();
var userID;
Constants constants = Constants();

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

    getSession().then((value) {
      get_data();
    });

    //get_data();

    //userID = await session_management.getUserID();
    //     toast_alert.successToast(userID);
  }

  getSession() async {
    userID = await session_management.getUserID();

    //toast_alert.successToast("hello " + userID);

    //get_data();
    return;
  }

  Future<List<Data>?> get_data() async {
    //toast_alert.successToast("hoi");
    List<Data>? datalist;
    ApiServices().getSubjectList(userID).then((value) {
      SubjectResponse response = SubjectResponse.fromJson(value);

      //toast_alert.successToast(response.status.toString());
      if (response.status == 0) {
        //subjectList = response.data as Future<SubjectResponse>;
        datalist = response.data;
        toast_alert.successToast(datalist?[0].subTitle.toString());
        print(datalist);
        return datalist;
      } else {}
    });

    return datalist;
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
        /*actions: [
          IconButton(
              onPressed: () {
                session_management.removeUser();

                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login_page', (Route<dynamic> route) => false);
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],*/
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
                  child: Text(
                    "Subject List",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),



              ],
            ),
          ),
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
