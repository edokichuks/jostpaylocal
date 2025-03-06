// TODO: Review this class...
class NetworkException {
  final int? statusCode;
  final String? error;
  final String message;

  NetworkException(
    this.message, {
    this.statusCode,
    this.error,
  });
}

class ExceptionResponse {
  bool? success;
  String? message;
  int? statusCode;
  String? timestamp;
  String? path;
  String? method;

  ExceptionResponse(
      {this.success,
      this.message,
      this.statusCode,
      this.timestamp,
      this.path,
      this.method});

  ExceptionResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    statusCode = json['statusCode'];
    timestamp = json['timestamp'];
    path = json['path'];
    method = json['method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> response = <String, dynamic>{};
    response['success'] = success;
    response['message'] = message;
    response['statusCode'] = statusCode;
    response['timestamp'] = timestamp;
    response['path'] = path;
    response['method'] = method;

    return response;
  }
}
