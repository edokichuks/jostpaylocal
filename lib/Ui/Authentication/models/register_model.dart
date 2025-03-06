class RegisterResponse {
  bool? success;
  String? message;
  RegisterModel? data;

  RegisterResponse({this.success, this.message, this.data});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];

    data = RegisterModel.fromJson(json["data"]);
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

class RegisterModel {
  String? firstName;
  String? lastName;
  String? phone;
  String? country;
  String? email;
  String? password;
  String? referralCode;

  RegisterModel({
    this.firstName,
    this.lastName,
    this.phone,
    this.password,
    this.country,
    this.referralCode,
    this.email,
  });

  RegisterModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    country = json['country'];
    password = json['password'];
    referralCode = json['referral_code'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> response = <String, dynamic>{};

    response['last_name'] = lastName;
    response['first_name'] = firstName;
    response['phone'] = phone;
    response['country'] = country;
    response['password'] = password;
    response['referral_code'] = response;
    response['email'] = email;

    return response;
  }
}
