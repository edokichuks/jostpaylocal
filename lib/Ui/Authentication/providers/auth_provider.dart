import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Ui/Authentication/models/login_response.dart';
import 'package:jost_pay_wallet/Ui/Authentication/models/register_model.dart';
import 'package:jost_pay_wallet/Ui/Authentication/presentation/OtpScreen.dart';
import 'package:jost_pay_wallet/Ui/Authentication/repository/auth_repository.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/DashboardScreen.dart';
import 'package:jost_pay_wallet/Values/Helper/logger.dart';
import 'package:jost_pay_wallet/domain/info.dart';
import 'package:jost_pay_wallet/services/local_storage.dart/local_storage_export.dart';
import 'package:jost_pay_wallet/services/navigation_service.dart';

class AuthProvider extends ChangeNotifier {
  final LocalStorageRepo _localStorageRepo;
  AuthProvider(this._localStorageRepo);
  static final context = NavigationService.navigatorKey.currentContext;
  final authRepository = AuthRepository();
  // final LocalStorageService storageService = LocalStorageService();
  bool isRegistering = false;
  bool isVerifyEmail = false;
  bool isForgetPassword = false;
  bool isLogin = false;
  bool isVerifyToken = false;
  bool isResetPassword = false;
  bool isChangePassword = false;
  bool isLogOut = false;
  String country = "";
  String socialMedia = "";
  String idType = "";
  String userName = "";
  String userEmail = "";
  String email = "";
  String tempToken = "";
  String password = "";
  String? error;
  String id = "";

  // Future getRegister(String fullName, String email, String password,
  //     bool informationSubscription) async {
  //   try {
  //     setError(null);
  //     setgetRegister(true);
  //     final response = await authRepository.register(
  //         fullName, email, password, informationSubscription);
  //     if (response.success == true) {
  //       registerResponse = response;
  //       setgetRegister(true);
  //       Navigator.pushNamed(context!, AppRoutes.verifyEmail);
  //     } else {
  //       Info.showErrorMessage(response.message);
  //       setgetRegister(false);
  //     }
  //   } catch (e) {
  //     setgetRegister(false);
  //   }
  // }

  Future verifyEmail(
    String pin,
  ) async {
    debugLog('Attempting to verify email');
    try {
      setError(null);
      setgetVerifyEmail(true);

      final response = await authRepository.verifyEmail(pin, tempToken);
      debugLog('verigy Response =>> ${response.toString()}');

      if (response.result == true) {
        _localStorageRepo.put(
            LocalStoreKeysManger.token.rawValue, response.token);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacement(
              NavigationService.navigatorKey.currentContext!,
              MaterialPageRoute(builder: (context) => const DashboardScreen()));
        });
      } else {
        Info.showErrorMessage(response.message);
        setError(response.message);
      }

      setgetVerifyEmail(false);
    } catch (e) {
      setgetVerifyEmail(false);
    }
  }

  // Future verifyToken(String pin, bool isReset, String id) async {
  //   try {
  //     setError(null);
  //     setgetVerifyToken(true);
  //     final response = await authRepository.verifyToken(pin, id);

  //     if (response.data != null) {
  //       verifyTokenResponse = response;
  //       id = response.data!.id!;
  //       setgetVerifyToken(true);

  //       isReset == true
  //           ? Navigator.push(context!,
  //               MaterialPageRoute(builder: (_) => const NewPasswordScreen()))
  //           : Navigator.pushNamed(context!, AppRoutes.roleSelection);
  //     } else {
  //       setgetVerifyToken(false);
  //     }
  //   } catch (e) {
  //     setgetVerifyToken(false);
  //   }
  // }

  Future login(String email, String password) async {
    debugLog('Attempting to signin');
    try {
      setError(null);
      setgetLogin(true);

      final response = await authRepository.login(email, password);
      debugLog('login Response =>> ${response.toString()}');

      if (response.result == true) {
        settempToken(response.token);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacement(
              NavigationService.navigatorKey.currentContext!,
              MaterialPageRoute(builder: (context) => const OtpScreen()));
        });
      } else {
        Info.showErrorMessage(response.message);
      }

      setgetLogin(false);
    } catch (e) {
      setgetLogin(false);
    }
  }

  Future signup({required RegisterModel model}) async {
    debugLog('Attempting to signup with ${model.toJson()}');
    try {
      setError(null);
      setgetRegister(true);

      final response = await authRepository.register(model: model);
      debugLog('signup Response =>> ${response.toString()}');

      if (response.result == true) {
        settempToken(response.token);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacement(
              NavigationService.navigatorKey.currentContext!,
              MaterialPageRoute(builder: (context) => const OtpScreen()));
        });
      } else {
        Info.showErrorMessage(response.message);
      }

      setgetRegister(false);
    } catch (e) {
      setgetRegister(false);
    }
  }

  // Future forgetPassword(String email) async {
  //   try {
  //     setError(null);

  //     final response = await authRepository.forgotPassword(email);

  //     if (response.success == true) {
  //       genericResponse = response;
  //       setgetForgetPassword(true);
  //       Navigator.pushNamed(context!, AppRoutes.otpSent);
  //     } else {
  //       setgetForgetPassword(false);
  //     }
  //   } catch (e) {
  //     setgetForgetPassword(false);
  //   }
  // }

  // Future resetPassword(String password) async {
  //   try {
  //     setError(null);
  //     setgetResetPassword(true);
  //     final response = await authRepository.resetPassword(password);

  //     if (response.success == true) {
  //       setgetResetPassword(true);
  //       genericResponse = response;
  //       Navigator.pushNamed(context!, AppRoutes.passwordChanged);
  //     } else {
  //       setgetResetPassword(false);
  //     }
  //   } catch (e) {
  //     setgetResetPassword(false);
  //   }
  // }

  // Future changePassword(String currentPassword, String newPassword) async {
  //   try {
  //     setError(null);

  //     final response =
  //         await authRepository.changePassword(currentPassword, newPassword);
  //     if (response.success == true) {
  //       setgetChangePassword(true);
  //       genericResponse = response;
  //       //Navigator.pushNamed(context, AppRoutes.passwordChanged);
  //     } else {
  //       setgetChangePassword(false);
  //     }
  //   } catch (e) {
  //     setgetChangePassword(false);
  //   }
  // }

  // logOut() async {
  //   await storageService.deleteSecureData("userToken");
  //   await storageService.writeSecureData("isOnboarded", "False");
  //   Navigator.pushNamed(context!, AppRoutes.login);
  // }

  void setgetRegister(value) {
    isRegistering = value;
    notifyListeners();
  }

  void settempToken(value) {
    tempToken = value;
    notifyListeners();
  }

  void setgetResetPassword(value) {
    isResetPassword = value;
    notifyListeners();
  }

  void setgetLogin(value) {
    isLogin = value;
    notifyListeners();
  }

  void setgetForgetPassword(value) {
    isForgetPassword = value;
    notifyListeners();
  }

  void setgetVerifyEmail(value) {
    isVerifyEmail = value;
    notifyListeners();
  }

  void setgetVerifyToken(value) {
    isVerifyToken = value;
    notifyListeners();
  }

  void setgetChangePassword(value) {
    isChangePassword = value;
    notifyListeners();
  }

  void setgetLogOut(value) {
    isChangePassword = value;
    notifyListeners();
  }

  void setgetCountry(value) {
    country = value;
    notifyListeners();
  }

  void setgetSocialMedia(value) {
    socialMedia = value;
    notifyListeners();
  }

  void setgetIdType(value) {
    idType = value;
    notifyListeners();
  }

  void setgetUserEmail(value) {
    userEmail = value;
    notifyListeners();
  }

  void setgetEmail(value) {
    email = value;
    notifyListeners();
  }

  void setgetPassword(value) {
    password = value;
    notifyListeners();
  }

  void setError(value) {
    error = value;
    notifyListeners();
  }
}
