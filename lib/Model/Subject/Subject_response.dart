class SubjectResponse {
  int? status;
  List<subData>? data;

  SubjectResponse({this.status, this.data});

  SubjectResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <subData>[];
      json['data'].forEach((v) {
        data!.add(new subData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class subData {
  int? subjectID;
  String? subTitle;
  String? createdAt;
  String? updatedAt;

  subData({this.subjectID, this.subTitle, this.createdAt, this.updatedAt});

  subData.fromJson(Map<String, dynamic> json) {
    subjectID = json['subjectID'];
    subTitle = json['sub_title'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['subjectID'] = subjectID;
    data['sub_title'] = subTitle;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
