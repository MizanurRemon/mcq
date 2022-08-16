import 'package:flutter/material.dart';
import 'package:mcq/Page/Home_page.dart';
import 'package:mcq/Page/SplashPage.dart';
import 'package:mcq/Page/Add_subject_page.dart';
import 'package:mcq/Provider/DataProvider.dart';
import 'Subject_details_page.dart';
import 'login_page.dart';
import 'package:provider/provider.dart';

//Session_management session_management = Session_management();

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => DataProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/splash_page",
      routes: {
        "/login_page": (context) => const LoginPage(),
        "/home_page": (context) => const Home_Page(),
        "/splash_page": (context) => const SplashPage(),
        "/add_subject_page": (context) => const Add_subject_page(),
        "/subject_details_page": (context) => const Subject_details_page(),
      },
    );
  }

/*setInitialRoute() async{
    var initRoute;
    var userID = await session_management.getUserID();
    if(userID != null){
      //toast_alert.successToast(userID);
      initRoute = "/login_page";
    }else{
      initRoute = "/home_page";
    }

    return initRoute;
  }*/
}
