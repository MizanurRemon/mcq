class Login_response {
  int? status;
  String? message;
  Data? data;

  Login_response({this.status, this.message, this.data});

  Login_response.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? adminID;

  Data({this.adminID});

  Data.fromJson(Map<String, dynamic> json) {
    adminID = json['adminID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adminID'] = this.adminID;
    return data;
  }
}
