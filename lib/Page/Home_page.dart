import 'package:flutter/material.dart';
import 'package:mcq/API/Api_services.dart';
import 'package:mcq/Model/Common/Common_response.dart';
import 'package:mcq/Provider/DataProvider.dart';
import 'package:mcq/Sessions/Session_management.dart';
import 'package:mcq/Toast/Toast_alert.dart';
import 'package:mcq/Utils/Constants.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../Model/Subject/Data.dart';
import 'package:provider/provider.dart';

import 'package:shaky_animated_listview/animators/grid_animator.dart';
import 'package:shaky_animated_listview/animators/shake_transition.dart';
import 'package:shaky_animated_listview/scroll_animator.dart';
import 'package:shaky_animated_listview/widgets/animated_gridview.dart';
import 'package:shaky_animated_listview/widgets/animated_listview.dart';

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
  }

  getSession() async {
    userID = await session_management.getUserID();

    return;
  }

  update_subject(String subjectID, String title) {
    setState(() {
      ApiServices().updateSubject(subjectID, title).then((value) {
        CommonResponse response = CommonResponse.fromJson(value);
        if (response.status == 1) {
          toast_alert.successToast(response.message);
          Navigator.of(context).pop();
        } else {
          toast_alert.errorToast(response.message);
        }

        //return response.status;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    final providerData = Provider.of<DataProvider>(context);

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
                  height: screenHeight - 150,
                  child: FutureBuilder<List<Data>>(
                    future: ApiServices().getSubjectList(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Data>? data = snapshot.data as List<Data>;

                        return GridView(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2,
                          ),
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          children: List.generate(
                            data.length,
                            (index) {
                              return GridAnimatorWidget(
                                child: ZoomTapAnimation(
                                    onTap: () {
                                      //toast_alert.successToast(data[index].subjectID.toString());
                                      providerData.receiveIDAndName(
                                          data[index].subjectID.toString(),
                                          data[index].subTitle);
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              '/subject_details_page',
                                              (Route<dynamic> route) => true);
                                    },
                                    onLongTap: () {
                                      TextEditingController titleController =
                                          TextEditingController(
                                              text: data[index].subTitle);
                                      BuildContext dialogContext;
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          //dialogContext = context;
                                          return Expanded(
                                            child: AlertDialog(
                                              actions: [
                                                SizedBox(
                                                  width: screenWidth,
                                                  child: const Text(
                                                    "Update Subject",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                SizedBox(
                                                  width: screenWidth,
                                                  child: TextField(
                                                    controller: titleController,
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText: "Subject Title",
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                SizedBox(
                                                  width: screenWidth,
                                                  height: 40,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      update_subject(
                                                          data[index]
                                                              .subjectID
                                                              .toString(),
                                                          titleController.text
                                                              .toString()
                                                              .trim());
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary: Colors
                                                                .blueGrey),
                                                    child: const Text(
                                                      "Update",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    enableLongTapRepeatEvent: false,
                                    longTapRepeatDuration:
                                        const Duration(milliseconds: 100),
                                    begin: 1.0,
                                    end: 0.93,
                                    beginDuration:
                                        const Duration(milliseconds: 20),
                                    endDuration:
                                        const Duration(milliseconds: 120),
                                    beginCurve: Curves.decelerate,
                                    endCurve: Curves.fastOutSlowIn,
                                    child: Card(
                                      semanticContainer: true,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      color: Colors.blueGrey,
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Text(
                                            data[index].subTitle.toString(),
                                            style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    )),
                              );
                            },
                          ),
                        );
                      } else if (snapshot.hasError) {
                        print("${snapshot.error}");
                        return Text("${snapshot.error}");
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
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
