import 'dart:convert';

/// subjectID : 8
/// sub_title : "বাংলা 2"
/// created_at : "2022-07-30 01:14:33"
/// updated_at : "2022-07-30 01:15:19"

//Data dataFromJson(String str) => Data.fromJson(json.decode(str));

//String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  final int? subjectID;
  final String? subTitle;
  final String? createdAt;
  final String? updatedAt;

  Data({
    this.subjectID,
    this.subTitle,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        subjectID: json['subjectID'],
        subTitle: json['sub_title'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['subjectID'] = this.subjectID;
    data['sub_title'] = this.subTitle;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;

    return data;
  }
}
