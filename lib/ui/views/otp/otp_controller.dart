import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tjw_analytics_new/services/api_base_service.dart';
import 'package:tjw_analytics_new/services/request_method.dart';
import 'package:tjw_analytics_new/ui/views/dashboard/dashboard_screen.dart';

import '../../../services/secure_storage_service.dart';
import '../event_list/event_list_screen.dart';

class OtpController extends GetxController{
  final data = Get.arguments as Map<String, dynamic>;

  final TextEditingController otpController = TextEditingController();
  FocusNode otpFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  var isLoading = false.obs;
  String mobileNumber = '';
  String otpId = '';

  var secondsRemaining = 60.obs;   // countdown time
  var canResend = false.obs;       // enable/disable resend button
  Timer? timer;


  @override
  Future<void> onInit() async {
    otpController.text = data['sentOtp'].toString() ?? "";
    mobileNumber = data['mobileNumber']?.toString() ?? "";
    // otpController.text = data['sentOtp'].toString();
    startOtpTimer();
    super.onInit();
  }

  void startOtpTimer() {
    secondsRemaining.value = 60;   // reset to 60 seconds
    canResend.value = false;

    timer?.cancel();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }


  @override
  void dispose() {
    // TODO: implement dispose
    otpController.dispose();
    otpFocusNode.dispose();

    super.dispose();
  }

  Future<void> verifyOtp() async {
    if (formKey.currentState?.validate() != true) {
      print('Form is invalid. Please correct the errors.');
      return;
    }

    otpId = (await SecureStorageService().read("otpId"))!;

    try {
      isLoading(true);

      final response = await ApiBaseService.request<Map<String, dynamic>>(
        '/OTP/VerifyOTP?otpId=$otpId&enteredOtp=${otpController.text}',
        method: RequestMethod.GET,
        authenticated: false,
      );

      final status = response['status']?.toString();
      final message = response['message']?.toString();

      if (status == "200") {
        final data = response['data'] as Map<String, dynamic>?;

        /// Fetch temporary stored mobile number
        final mobile = await SecureStorageService().read("tempMobile");

        if (mobile != null) {
          await SecureStorageService().write("mobileNumber", mobile);
        }

        // Example: save userId or mobileNumber
        if (data != null) {
          await SecureStorageService().write("userId", data['userId'].toString());
          await SecureStorageService().write("userName", data['userName'].toString());
        }

        /// Mark session as logged in
        await SecureStorageService().write("isLoggedIn", "true");

        /// Remove temporary value
        await SecureStorageService().delete("tempMobile");


        Fluttertoast.showToast(msg: message ?? "OTP Verified");

        Get.offAll(() => EventListScreen());
  //      Get.offAll(() => DashboardScreen());
      } else if (status == "100") {
        Fluttertoast.showToast(msg: message ?? "Something went wrong");
      } else {
        Fluttertoast.showToast(msg: "Unexpected response: $response");
      }
    } catch (e) {
      print("Error fetching visitor list: $e");
      Fluttertoast.showToast(msg: "Server error, please try again");
    } finally {
      isLoading(false);
    }
  }

}