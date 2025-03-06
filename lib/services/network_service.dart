import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:jost_pay_wallet/Values/Helper/logger.dart';
import 'package:jost_pay_wallet/domain/info.dart';
import 'network_exception.dart';
import "package:http/http.dart" as http;

class NetworkService {
  final String apiBaseUrl = "http://project.jostpay.com/apis";
  // static final context = NavigationService.navigatorKey.currentContext;

  void throwExceptionOnFail(http.Response response) async {
    if (response.statusCode != 200 && response.statusCode != 201) {
      if (response.statusCode == 500 || response.statusCode == 404) {
        debugLog(response.body);
        Info.showErrorMessage(
            ExceptionResponse.fromJson(jsonDecode(response.body)).message);
        throw NetworkException(
          'An error occurred',
          error: response.body,
          statusCode: response.statusCode,
        );
      } else if (response.statusCode == 401) {
        Info.showErrorMessage("Unauthorized token, login again to refresh");
        // Navigator.pushNamed(context!, AppRoutes.login);
      } else {
        Info.showErrorMessage(
            ExceptionResponse.fromJson(jsonDecode(response.body)).message);
        throw NetworkException(
          'An error occurred',
          error: response.body,
          statusCode: response.statusCode,
        );
      }
    }
  }

  Future<dynamic> get(String url, {Map<String, String>? headers}) async {
    try {
      var response = await http
          .get(
            Uri.parse('$apiBaseUrl/$url'),
            headers: headers,
          )
          .timeout(const Duration(minutes: 2));
      debugLog('URL => ${'$apiBaseUrl/$url'}');
      debugLog('Get request response body ${response.body}');

      throwExceptionOnFail(response);

      return jsonDecode(response.body);
    } on TimeoutException {
      throw NetworkException('Request timeout');
    } on SocketException {
      Info.showErrorMessage("No internet connection");

      throw NetworkException('There is no internet');
    } on HttpException {
      throw NetworkException('There is an http exception');
    } on FormatException {
      throw NetworkException('There is a format exception');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post(
    String url, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    debugLog('Body data coming in => $body');
    debugLog('Body data going out => ${Uri(queryParameters: body).query}');
    try {
      var response = await http
          .post(
            Uri.parse('$apiBaseUrl/$url'),
            headers: headers,
            // body: jsonEncode(body),
            body: Uri(queryParameters: body).query,
          )
          .timeout(
            const Duration(minutes: 5),
          );
      throwExceptionOnFail(response);
      return jsonDecode(response.body);
    } on TimeoutException {
      throw NetworkException('Request timeout');
    } on SocketException {
      Info.showErrorMessage("No internet connection");
      throw NetworkException('There is no internet',
          error: 'Kindly check your internet connection...');
    } on HttpException {
      throw NetworkException('There is an http exception');
    } on FormatException {
      throw NetworkException('There is a format exception');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> patch(
    String url, {
    Map<dynamic, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      var response = await http
          .patch(
            Uri.parse('$apiBaseUrl/$url'),
            body: jsonEncode(body),
            headers: headers,
          )
          .timeout(const Duration(minutes: 2));

      throwExceptionOnFail(response);
      return jsonDecode(response.body);
    } on TimeoutException {
      throw NetworkException('Request timeout');
    } on SocketException {
      Info.showErrorMessage("No internet connection");
      throw NetworkException('There is no internet');
    } on HttpException {
      throw NetworkException('There is an http exception');
    } on FormatException {
      throw NetworkException('There is a format exception');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> patchWithoutBody(
    String url, {
    Map<String, String>? headers,
  }) async {
    try {
      var response = await http
          .patch(
            Uri.parse('$apiBaseUrl/$url'),
            headers: headers,
          )
          .timeout(const Duration(minutes: 2));

      throwExceptionOnFail(response);
      return jsonDecode(response.body);
    } on TimeoutException {
      throw NetworkException('Request timeout');
    } on SocketException {
      Info.showErrorMessage("No internet connection");
      throw NetworkException('There is no internet');
    } on HttpException {
      throw NetworkException('There is an http exception');
    } on FormatException {
      throw NetworkException('There is a format exception');
    } catch (e) {
      rethrow;
    }
  }

  Map<String, String> query(String id) {
    Map<String, String> headers = {
      "id": id,
    };
    return headers;
  }

  Future<dynamic> parseWithQuery(
    String url, {
    Map<dynamic, dynamic>? body,
    Map<String, String>? headers,
    String? id,
  }) async {
    try {
      var response = await http
          .patch(
            Uri.parse('$apiBaseUrl/$url').replace(queryParameters: query(id!)),
            body: jsonEncode(body),
            headers: headers,
          )
          .timeout(const Duration(minutes: 2));

      throwExceptionOnFail(response);
      return jsonDecode(response.body);
    } on TimeoutException {
      throw NetworkException('Request timeout');
    } on SocketException {
      Info.showErrorMessage("No internet connection");
      throw NetworkException('There is no internet');
    } on HttpException {
      throw NetworkException('There is an http exception');
    } on FormatException {
      throw NetworkException('There is a format exception');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getWithPath(String url,
      {Map<String, String>? headers, String? id}) async {
    try {
      var response = await http
          .get(
            Uri.parse('$apiBaseUrl/$url/$id'),
            headers: headers,
          )
          .timeout(const Duration(minutes: 2));

      throwExceptionOnFail(response);

      return jsonDecode(response.body);
    } on TimeoutException {
      throw NetworkException('Request timeout');
    } on SocketException {
      Info.showErrorMessage("No internet connection");
      throw NetworkException('There is no internet');
    } on HttpException {
      throw NetworkException('There is an http exception');
    } on FormatException {
      throw NetworkException('There is a format exception');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> postWithPath(String url,
      {Map<String, String>? headers,
      String? id,
      Map<String, dynamic>? body}) async {
    try {
      var response = await http
          .post(Uri.parse('$apiBaseUrl/$url/$id/report'),
              headers: headers, body: jsonEncode(body))
          .timeout(const Duration(minutes: 2));

      throwExceptionOnFail(response);
      return jsonDecode(response.body);
    } on TimeoutException {
      throw NetworkException('Request timeout');
    } on SocketException {
      Info.showErrorMessage("No internet connection");
      throw NetworkException('There is no internet');
    } on HttpException {
      throw NetworkException('There is an http exception');
    } on FormatException {
      throw NetworkException('There is a format exception');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteWithPath(String url,
      {Map<String, String>? headers, String? id}) async {
    try {
      var response = await http
          .delete(
            Uri.parse('$apiBaseUrl/$url/$id'),
            headers: headers,
          )
          .timeout(const Duration(minutes: 2));

      throwExceptionOnFail(response);

      return jsonDecode(response.body);
    } on TimeoutException {
      throw NetworkException('Request timeout');
    } on SocketException {
      Info.showErrorMessage("No internet connection");
      throw NetworkException('There is no internet');
    } on HttpException {
      throw NetworkException('There is an http exception');
    } on FormatException {
      throw NetworkException('There is a format exception');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> delete(String url,
      {Map<String, String>? headers, Map<dynamic, dynamic>? body}) async {
    try {
      var response = await http
          .delete(Uri.parse('$apiBaseUrl/$url'), headers: headers, body: body)
          .timeout(const Duration(minutes: 2));
      throwExceptionOnFail(response);
      return jsonDecode(response.body);
    } on TimeoutException {
      throw NetworkException('Request timeout');
    } on SocketException {
      Info.showErrorMessage("No internet connection");
      throw NetworkException('There is no internet');
    } on HttpException {
      throw NetworkException('There is an http exception');
    } on FormatException {
      throw NetworkException('There is a format exception');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> postWithQuery(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? query,
  }) async {
    try {
      var response = await http
          .post(
            Uri.parse('$apiBaseUrl/$url').replace(queryParameters: query),
            headers: headers,
          )
          .timeout(const Duration(minutes: 2));

      throwExceptionOnFail(response);
      return jsonDecode(response.body);
    } on TimeoutException {
      throw NetworkException('Request timeout');
    } on SocketException {
      Info.showErrorMessage("No internet connection");
      throw NetworkException('There is no internet');
    } on HttpException {
      throw NetworkException('There is an http exception');
    } on FormatException {
      throw NetworkException('There is a format exception');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getWithQuery(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? query,
  }) async {
    try {
      var response = await http
          .get(
            Uri.parse('$apiBaseUrl/$url').replace(queryParameters: query),
            headers: headers,
          )
          .timeout(const Duration(minutes: 2));
      throwExceptionOnFail(response);
      return jsonDecode(response.body);
    } on TimeoutException {
      throw NetworkException('Request timeout');
    } on SocketException {
      Info.showErrorMessage("No internet connection");
      throw NetworkException('There is no internet');
    } on HttpException {
      throw NetworkException('There is an http exception');
    } on FormatException {
      throw NetworkException('There is a format exception');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> patchWithQuery(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? query,
  }) async {
    try {
      var response = await http
          .patch(
            Uri.parse('$apiBaseUrl/$url').replace(queryParameters: query),
            headers: headers,
          )
          .timeout(const Duration(minutes: 2));

      throwExceptionOnFail(response);
      return jsonDecode(response.body);
    } on TimeoutException {
      throw NetworkException('Request timeout');
    } on SocketException {
      Info.showErrorMessage("No internet connection");
      throw NetworkException('There is no internet');
    } on HttpException {
      throw NetworkException('There is an http exception');
    } on FormatException {
      throw NetworkException('There is a format exception');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> patchWithPath(String url,
      {Map<String, String>? headers, String? id}) async {
    try {
      var response = await http
          .patch(
            Uri.parse('$apiBaseUrl/$url/$id'),
            headers: headers,
          )
          .timeout(const Duration(minutes: 2));
      throwExceptionOnFail(response);
      return jsonDecode(response.body);
    } on TimeoutException {
      throw NetworkException('Request timeout');
    } on SocketException {
      Info.showErrorMessage("No internet connection");
      throw NetworkException('There is no internet');
    } on HttpException {
      throw NetworkException('There is an http exception');
    } on FormatException {
      throw NetworkException('There is a format exception');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> patchWithPathBody(String url,
      {Map<String, String>? headers,
      String? id,
      Map<dynamic, dynamic>? body}) async {
    try {
      var response = await http
          .patch(
            Uri.parse('$apiBaseUrl/$url/$id'),
            body: jsonEncode(body),
            headers: headers,
          )
          .timeout(const Duration(minutes: 2));
      throwExceptionOnFail(response);
      return jsonDecode(response.body);
    } on TimeoutException {
      throw NetworkException('Request timeout');
    } on SocketException {
      Info.showErrorMessage("No internet connection");
      throw NetworkException('There is no internet');
    } on HttpException {
      throw NetworkException('There is an http exception');
    } on FormatException {
      throw NetworkException('There is a format exception');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> postMultipart(
    String url, {
    Map<String, dynamic>? files,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      var request =
          http.MultipartRequest("PATCH", Uri.parse("$apiBaseUrl/$url"));

      request.headers.addAll(headers!);

      if (body != null) {
        for (var data in body.entries) {
          request.fields[data.key] = data.value.toString();
        }
      }

      if (files != null) {
        for (var data in files.entries) {
          if (data.value != null) {
            request.files.add(await http.MultipartFile.fromPath(
              data.key,
              data.value,
              // contentType: new MediaType('application', 'x-tar'),
            ));
          }
        }
      }

      final http.StreamedResponse streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse)
          .timeout(const Duration(minutes: 2));

      throwExceptionOnFail(response);
      return jsonDecode(response.body);
    } on TimeoutException {
      throw NetworkException('Request timeout');
    } on SocketException {
      Info.showErrorMessage("No internet connection");
      throw NetworkException('There is no internet');
    } on HttpException {
      throw NetworkException('There is an http exception');
    } on FormatException {
      throw NetworkException('There is a format exception');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> postMultipart2(
    String url, {
    Map<String, dynamic>? files,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      var request =
          http.MultipartRequest("POST", Uri.parse("$apiBaseUrl/$url"));

      request.headers.addAll(headers!);

      if (body != null) {
        for (var data in body.entries) {
          request.fields[data.key] = data.value.toString();
        }
      }

      if (files != null) {
        for (var data in files.entries) {
          if (data.value != null) {
            request.files.add(await http.MultipartFile.fromPath(
              data.key,
              data.value,
              // contentType: new MediaType('application', 'x-tar'),
            ));
          }
        }
      }
      final http.StreamedResponse streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse)
          .timeout(const Duration(minutes: 2));
      throwExceptionOnFail(response);
      return jsonDecode(response.body);
    } on TimeoutException {
      throw NetworkException('Request timeout');
    } on SocketException {
      Info.showErrorMessage("No internet connection");
      throw NetworkException('There is no internet');
    } on HttpException {
      throw NetworkException('There is an http exception');
    } on FormatException {
      throw NetworkException('There is a format exception');
    } catch (e) {
      rethrow;
    }
  }
}
