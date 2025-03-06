class GenericResponse {
  bool? success;
  String? message;

  GenericResponse({
    this.success,
    this.message,
  });

  GenericResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> response = <String, dynamic>{};
    response['success'] = success;
    response['message'] = message;

    return response;
  }
}
