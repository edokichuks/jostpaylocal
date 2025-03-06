import 'dart:convert';

import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable {
  final bool? result;
  final String? token;
  final String? loginMethod;
  final String? message;

  const LoginResponse({this.result, this.token, this.loginMethod, this.message});

  factory LoginResponse.fromMap(Map<String, dynamic> data) => LoginResponse(
        result: data['result'] as bool?,
        token: data['token'] as String?,
        loginMethod: data['login_method'] as String?,
        message: data['message'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'result': result,
        'token': token,
        'login_method': loginMethod,
        'message': message,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LoginResponse].
  factory LoginResponse.fromJson(String data) {
    return LoginResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LoginResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [result, token, loginMethod, message];
}
