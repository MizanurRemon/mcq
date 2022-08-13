/// status : 0
/// data : [{"subjectID":8,"sub_title":"বাংলা 2","created_at":"2022-07-30 01:14:33","updated_at":"2022-07-30 01:15:19"},{"subjectID":9,"sub_title":"English","created_at":"2022-07-30 01:08:56","updated_at":"2022-07-30 01:08:56"},{"subjectID":10,"sub_title":"Geology","created_at":"2022-07-30 01:10:49","updated_at":"2022-07-30 01:10:49"}]

class SubjectResponse {
  SubjectResponse({
    num? status,
    List<Data>? data,
  }) {
    _status = status;
    data = data;
  }

  SubjectResponse.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

  num? _status;
  List<Data>? data;

  SubjectResponse copyWith({
    num? status,
    List<Data>? data,
  }) =>
      SubjectResponse(
        status: status ?? _status,
        data: data ?? data,
      );

  num? get status => _status;

  List<Data>? get dataList => data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// subjectID : 8
/// sub_title : "বাংলা 2"
/// created_at : "2022-07-30 01:14:33"
/// updated_at : "2022-07-30 01:15:19"

class Data {
  Data({
    num? subjectID,
    String? subTitle,
    String? createdAt,
    String? updatedAt,
  }) {
    _subjectID = subjectID;
    _subTitle = subTitle;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _subjectID = json['subjectID'];
    _subTitle = json['sub_title'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  num? _subjectID;
  String? _subTitle;
  String? _createdAt;
  String? _updatedAt;

  Data copyWith({
    num? subjectID,
    String? subTitle,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
        subjectID: subjectID ?? _subjectID,
        subTitle: subTitle ?? _subTitle,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  num? get subjectID => _subjectID;

  String? get subTitle => _subTitle;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['subjectID'] = _subjectID;
    map['sub_title'] = _subTitle;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
