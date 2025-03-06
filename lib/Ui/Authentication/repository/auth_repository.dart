import 'package:jost_pay_wallet/Ui/Authentication/models/login_response.dart';
import 'package:jost_pay_wallet/services/helper_service.dart';
import 'package:jost_pay_wallet/services/navigation_service.dart';
import 'package:jost_pay_wallet/services/network_service.dart';

class AuthRepository {
  final NetworkService networkService = NetworkService();
  // final LocalStorageService storageService = LocalStorageService();
  static final context = NavigationService.navigatorKey.currentContext;

  var headers = HelperService.buildHeader2();
  String id = "";

  // Future<RegisterResponse> register(String fullName, String email,
  //     String password, bool informationSubscription) async {
  //   var body = <String, dynamic>{
  //     'fullName': fullName,
  //     'email': email,
  //     'password': password,
  //     'informationSubscription': informationSubscription
  //   };

  //   var response = await networkService.post("auth/register",
  //       headers: headers, body: body);
  //   var user = RegisterResponse.fromJson(response);
  //   await storageService.writeSecureData("userEmail", user.data!.email!);

  //   return RegisterResponse.fromJson(response);
  // }

  Future<LoginResponse> login(String email, String password) async {
    var body = <String, dynamic>{
      'email': email,
      'password': password,
    };

    var response =
        await networkService.post("login", headers: headers, body: body);

    var resp = LoginResponse.fromMap(response);
    if (resp.result == true) {
      // await storageService.writeSecureData("userToken", resp.token!);
    }
    return LoginResponse.fromMap(response);
  }

  // Future<VerifyEmailResponse> verifyEmail(String pin) async {
  //   var response = await networkService.postWithQuery(
  //     "auth/verification",
  //     headers: headers,
  //     query: HelperService.buildQuery(pin),
  //   );

  //   var data = VerifyEmailResponse.fromJson(response).data!;
  //   await storageService.writeSecureData("userToken", data.token!);
  //   await storageService.writeSecureData("userId", data.uuid!);
  //   return VerifyEmailResponse.fromJson(response);
  // }

  // Future<GenericResponse> forgotPassword(String email) async {
  //   var body = <String, dynamic>{
  //     'email': email,
  //   };
  //   var response = await networkService.post("auth/forgot-password",
  //       headers: headers, body: body);
  //   return GenericResponse.fromJson(response);
  // }

  // Future<GenericResponse> resetPassword(String password) async {
  //   id = await storageService.readSecureData("userId");
  //   var body = <String, dynamic>{'id': id, 'password': password};
  //   var response = await networkService.post("auth/reset-password",
  //       headers: headers, body: body);
  //   return GenericResponse.fromJson(response);
  // }

  // Future<VerifyTokenResponse> verifyToken(String token, String id) async {
  //   var body = <String, dynamic>{'token': token};
  //   var response = await networkService.post("auth/verify-token",
  //       headers: headers, body: body);

  //   return VerifyTokenResponse.fromJson(response);
  // }

  // Future<GenericResponse> changePassword(
  //     String currentPassword, String newPassword) async {
  //   var body = <String, dynamic>{
  //     'currentPassword': currentPassword,
  //     'newPassword': newPassword
  //   };
  //   var response = await networkService.post("auth/change-password",
  //       headers: headers, body: body);
  //   return GenericResponse.fromJson(response);
  // }

  // Future<VerifyTokenResponse> verifyCelebrity(String token) async {
  //   var body = <String, dynamic>{'token': token};
  //   var response = await networkService.post("celebrity/verify",
  //       headers: headers, body: body);

  //   return VerifyTokenResponse.fromJson(response);
  // }
}
