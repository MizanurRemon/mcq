import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier{
  var subjectID;
  var subjectName;

  receiveIDAndName(var subjectID, var subjectName){
    this.subjectID = subjectID;
    this.subjectName = subjectName;
  }
}