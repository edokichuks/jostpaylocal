import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/services/navigation_service.dart';

class Info {
  static final context = NavigationService.navigatorKey.currentContext;
  static showErrorMessage(
    message,
  ) {
    Flushbar(
      message: message.toString(),
      backgroundColor: const Color(0xFFB92E00),
      flushbarStyle: FlushbarStyle.FLOATING,
      duration: const Duration(seconds: 2),
      flushbarPosition: FlushbarPosition.TOP,
      borderRadius: BorderRadius.circular(2),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: const EdgeInsets.all(0),
      leftBarIndicatorColor: Colors.redAccent[300],
    ).show(context!);
  }

  static showSuccessMessage(
    message,
  ) {
    Flushbar(
      message: message,
      backgroundColor: const Color(0xFF219653),
      flushbarStyle: FlushbarStyle.FLOATING,
      duration: const Duration(seconds: 5),
      flushbarPosition: FlushbarPosition.TOP,
      borderRadius: BorderRadius.circular(5),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: const EdgeInsets.all(0),
      leftBarIndicatorColor: const Color(0xFF219653),
    ).show(context!);
  }
}
