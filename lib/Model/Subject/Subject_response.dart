import 'Data.dart';
import 'dart:convert';

/// status : 0
/// data : [{"subjectID":8,"sub_title":"বাংলা 2","created_at":"2022-07-30 01:14:33","updated_at":"2022-07-30 01:15:19"},{"subjectID":9,"sub_title":"English","created_at":"2022-07-30 01:08:56","updated_at":"2022-07-30 01:08:56"},{"subjectID":10,"sub_title":"Geology","created_at":"2022-07-30 01:10:49","updated_at":"2022-07-30 01:10:49"}]

SubjectResponse subjectResponseFromJson(String str) =>
    SubjectResponse.fromJson(json.decode(str));

String subjectResponseToJson(SubjectResponse data) =>
    json.encode(data.toJson());

class SubjectResponse {
  SubjectResponse({
    this.status,
    this.data,
  });

  SubjectResponse.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

  num? status;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
