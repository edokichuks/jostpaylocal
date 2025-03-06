import 'package:jost_pay_wallet/Ui/Authentication/models/login_response.dart';
import 'package:jost_pay_wallet/Ui/Authentication/models/register_model.dart';
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

  Future<LoginResponse> register({required RegisterModel model}) async {
    final Map<String, dynamic> data = {
      'last_name': model.lastName,
      'first_name': model.firstName,
      'phone': model.phone,
      'country': model.country,
      'password': model.password,
      'referral_code': model.referralCode,
      'email': model.email
    };
    var response =
        await networkService.post("signup", headers: headers, body: data);

    var resp = LoginResponse.fromMap(response);
    if (resp.result == true) {
      // await storageService.writeSecureData("userToken", resp.token!);
    }
    return LoginResponse.fromMap(response);
  }

  Future<LoginResponse> verifyEmail(String pin, String token) async {
    final _header = {
      "Accept": "application/x-www-form-urlencoded",
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": token,
    };
    var response = await networkService
        .post("verify-email", headers: _header, body: {"code": pin});

    var resp = LoginResponse.fromMap(response);
    if (resp.result == true) {
      // await storageService.writeSecureData("userToken", resp.token!);
    }
    return LoginResponse.fromMap(response);
  }

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
