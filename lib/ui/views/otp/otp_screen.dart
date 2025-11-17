import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:pinput/pinput.dart';

import 'package:tjw_analytics_new/ui/views/dashboard/dashboard_screen.dart';

import '../../../common_widget/common_button.dart';
import '../../../common_widget/common_text_field.dart';
import '../../../common_widget/tap_outside_unfocus.dart';
import '../../../core/res/colors.dart';
import '../createAccount/createAccount_controller.dart';
import '../createAccount/createAccount_screen.dart';
import 'otp_controller.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final OtpController controller = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColor.black,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.background,
      body: SafeArea (
        child: TapOutsideUnFocus(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  SizedBox(height: 50),
                  SvgPicture.asset("assets/message.svg"),
                  SizedBox(height: 6),
                  Text("Enter Verification Code", style: TextStyle(fontSize: 24)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 85),
                    child: Text(
                      "We've sent a 4-digit code to +91 ${controller.mobileNumber}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColor.textDisable,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 50),
                  Pinput(
                    length: 4,
                    controller: controller.otpController,
                    focusNode: controller.otpFocusNode,
                    validator: (value) {
                      if (value == null || value.length != 4) {
                        return 'Enter valid 4-digit OTP';
                      }
                      return null;
                    },
                    defaultPinTheme: PinTheme(
                      width: 70,
                      height: 60,
                      textStyle: const TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColor.textDisable),
                      ),
                    ),
                    focusedPinTheme: PinTheme(
                      width: 60,
                      height: 60,
                      textStyle: const TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColor.primary,
                        ), // highlight on focus
                      ),
                    ),
                    submittedPinTheme: PinTheme(
                      width: 60,
                      height: 60,
                      textStyle: const TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColor.textDisable),
                      ),
                    ),
                    separatorBuilder: (index) => const SizedBox(width: 12),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {},
                  ),
                  SizedBox(height: 10),
                  Obx(() {
                    final sec = controller.secondsRemaining.value;

                    return InkWell(
                      onTap:
                          controller.canResend.value
                              ? () {
                                controller.startOtpTimer();
                                final sendOtpController = Get.find<CreateAccountController>();
                                sendOtpController.submit();
                                controller.otpController.clear();
                              }
                              : null,
                      child: Text(
                        controller.canResend.value
                            ? "Didn't receive OTP?  Resend Now"
                            : "Didn't receive OTP?  Resend OTP in 00:${sec.toString().padLeft(2, '0')}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color:
                              controller.canResend.value
                                  ? AppColor
                                      .primary // active color
                                  : AppColor.black, // normal text
                        ),
                      ),
                    );
                  }),

                  SizedBox(height: 60),
                  Obx(() {
                    return CommonButton(
                      text: "Verify Code",
                      isLoading: controller.isLoading.value,
                      onPressed: () {
                        print("Print");
                        controller.verifyOtp();
                      },
                      //      isDisabled: controller.otpController.text.isEmpty ? true : false,
                      borderRadius: BorderRadius.circular(40),
                      suffixIcon: SvgPicture.asset(
                        "assets/arrow_outward.svg",
                        color: Colors.white,
                      ),
                    );
                  }),
                  SizedBox(height: 26),
                  InkWell(
                    onTap: () {
                      Get.to(CreateAccountScreen());
                    },
                    child: Text(
                      "Change Phone Number",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColor.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
