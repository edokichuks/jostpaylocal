class VerifyEmailResponse {
  bool? success;
  String? message;
  Data? data;

  VerifyEmailResponse({this.success, this.message, this.data});

  VerifyEmailResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = Data.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> response = <String, dynamic>{};
    response['success'] = success;
    response['message'] = message;
    if (data != null) {
      response['data'] = data!.toJson();
    }
    return response;
  }
}

class Data {
  String? uuid;
  String? fullName;
  String? userName;
  String? email;
  String? type;
  String? token;
  bool? activeNotification;

  Data(
      {this.fullName,
      this.email,
      this.uuid,
      this.token,
      this.type,
      this.activeNotification,
      this.userName});

  Data.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    email = json['email'];
    uuid = json['uuid'];
    token = json['token'];
    type = json['type'];
    activeNotification = json['activeNotification'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> response = <String, dynamic>{};
    response['fullName'] = fullName;
    response['email'] = email;
    response['uuid'] = uuid;
    response['token'] = token;
    response['type'] = type;
    response['activeNotification'] = activeNotification;
    response['userName'] = userName;
    return response;
  }
}
