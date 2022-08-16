import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mcq/Provider/DataProvider.dart';
import 'package:provider/provider.dart';

class Subject_details_page extends StatefulWidget {
  const Subject_details_page({Key? key}) : super(key: key);

  @override
  State<Subject_details_page> createState() => _Subject_details_pageState();
}

class _Subject_details_pageState extends State<Subject_details_page> {
  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<DataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(providerData.subjectName),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Center(
          child: Text(""),
        ),
      ),
    );
  }
}
