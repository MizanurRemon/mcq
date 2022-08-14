import 'dart:convert';

/// subjectID : 8
/// sub_title : "বাংলা 2"
/// created_at : "2022-07-30 01:14:33"
/// updated_at : "2022-07-30 01:15:19"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    this.subjectID,
    this.subTitle,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(dynamic json) {
    subjectID = json['subjectID'];
    subTitle = json['sub_title'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  num? subjectID;
  String? subTitle;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['subjectID'] = subjectID;
    map['sub_title'] = subTitle;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
