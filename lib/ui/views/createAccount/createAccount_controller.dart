import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tjw_analytics_new/services/api_base_service.dart';
import 'package:tjw_analytics_new/services/request_method.dart';
import 'package:tjw_analytics_new/services/secure_storage_service.dart';
import 'package:tjw_analytics_new/ui/views/otp/otp_screen.dart';

class CreateAccountController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  FocusNode nameFocus = FocusNode();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode otpFocusNode = FocusNode();

  final formSignUp = GlobalKey<FormState>();

  var isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> submit() async {
    if (formSignUp.currentState?.validate() != true) {
      print('Form is invalid. Please correct the errors.');
      return;
    }

    try {
      isLoading(true);

      final response = await ApiBaseService.request<Map<String, dynamic>>(
        '/OTP/SentOTP?mobileNumber=${phoneController.text}',
        method: RequestMethod.GET,
        authenticated: false,
      );

      final status = response['status']?.toString();
      final message = response['message']?.toString();

      if (status == "200") {
        final data = response['data'] as Map<String, dynamic>?;

        if (data != null) {
       //   await SecureStorageService().write("mobileNumber", data['mobileNumber'].toString());

          /// Store temporarily just for OTP process
          await SecureStorageService().write("tempMobile", data['mobileNumber'].toString());

          await SecureStorageService().write("otpId", data['otpId'].toString());

          Fluttertoast.showToast(msg: message ?? "OTP Sent");
          Get.to(() => OtpScreen(), arguments: data);
        }
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
