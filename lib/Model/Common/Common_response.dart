import 'dart:convert';

/// status : 1
/// message : "successfully added"

class CommonResponse {
  CommonResponse({
    this.status,
    this.message,
  });

  CommonResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  num? status;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    return map;
  }
}
