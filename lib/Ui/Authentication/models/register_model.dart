class RegisterResponse {
  bool? success;
  String? message;
  Data? data;

  RegisterResponse({this.success, this.message, this.data});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
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
  String? fullName;
  String? email;

  Data({
    this.fullName,
    this.email,
  });

  Data.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];

    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> response = <String, dynamic>{};

    response['fullName'] = fullName;
    response['email'] = email;

    return response;
  }
}
