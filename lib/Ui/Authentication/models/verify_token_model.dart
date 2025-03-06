class VerifyTokenResponse {
  bool? success;
  String? message;
  Data? data;

  VerifyTokenResponse({this.success, this.message, this.data});

  VerifyTokenResponse.fromJson(Map<String, dynamic> json) {
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
  String? id;

  Data({
    this.id,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> response = <String, dynamic>{};
    response['id'] = id;
    return response;
  }
}
