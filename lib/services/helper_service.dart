class HelperService {
  static Map<String, String> buildHeader1(String token) {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    headers["Authorization"] = "Bearer $token";

    return headers;
  }

  static Map<String, String> buildHeader2() {
    Map<String, String> headers = {
      "Accept": "application/x-www-form-urlencoded",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    return headers;
  }

  static Map<String, String> buildQuery(String pin) {
    Map<String, String> query = {
      "token": pin,
    };

    return query;
  }
}

//Read this and understand

// var uri = Uri(
//   scheme: 'https',
//   host: 'example.com',
//   path: '/foo/bar',
//   fragment: 'baz',
//   queryParameters: _yourQueryParameters,
// );
