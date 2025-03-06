import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jost_pay_wallet/Ui/Authentication/presentation/SignUpScreen.dart';
import 'package:jost_pay_wallet/Ui/Authentication/providers/auth_provider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/DashboardScreen.dart';
import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Values/Helper/logger.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:jost_pay_wallet/Values/NewColor.dart';
import 'package:jost_pay_wallet/domain/info.dart';
import 'package:provider/provider.dart';
import '../../../Values/MyColor.dart';
import '../../../Values/MyStyle.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String emailCode = '';

  bool clearText = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 70, right: 16.w, left: 16.w),
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()));
                },
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      "assets/images/arrow_left.png",
                      fit: BoxFit.cover,
                    )),
              ),
              const SizedBox(
                height: 30,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Verify it's you",
                  style: MyStyle.tx28Black,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Row(
                children: [
                  Text('We send a code to ', style: MyStyle.tx16Gray),
                  Text(
                    "( *****@mail.com ).",
                    style: MyStyle.tx16Green,
                  )
                ],
              ),
              const Row(
                children: [
                  Text(
                    'Enter it here to verify your identity',
                    style: MyStyle.tx16Gray,
                  )
                ],
              ),
              const SizedBox(height: 28),
              OtpTextField(
                numberOfFields: 6,
                borderColor: Colors.white,
                fillColor: NewColor.inputFillColor,
                fieldWidth: 50,
                fieldHeight: 50,
                focusedBorderColor: MyColor.greenColor,
                textStyle: const TextStyle(
                    fontSize: 16,
                    height: 1.3,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
                filled: true,
                borderWidth: 0.68,
                borderRadius: const BorderRadius.all(Radius.circular(12.5)),
                showFieldAsBox: true,
                // clearText: clearText,
                autoFocus: true,
                onCodeChanged: (String code) {
                  if (code.length > 4) {
                    setState(() {
                      emailCode = code;
                    });
                  }
                },
                onSubmit: (String verificationCode) {
                  emailCode = verificationCode;
                },
              ),
              const SizedBox(height: 14),
              TextButton(
                onPressed: () => {},
                child: Text("Resend Code",
                    style: MyStyle.tx16Green
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(height: 28),
              Consumer<AuthProvider>(builder: (context, providerData, _) {
                return providerData.isVerifyEmail
                    ? const Center(
                        child: CupertinoActivityIndicator(
                        color: MyColor.greenColor,
                      ))
                    : SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () async {
                            if (emailCode.length == 6) {
                              debugLog('code sednding out $emailCode');
                              await providerData.verifyEmail(emailCode);
                            } else {
                              Info.showErrorMessage('Code not complete');
                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: MyColor.greenColor,
                            padding: const EdgeInsets.symmetric(
                                vertical: 16), // Padding
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // Rounded corners
                            ),
                          ),
                          child: Text(
                            "Confirm",
                            style: NewStyle.btnTx16SplashBlue
                                .copyWith(color: NewColor.mainWhiteColor),
                          ),
                        ),
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
