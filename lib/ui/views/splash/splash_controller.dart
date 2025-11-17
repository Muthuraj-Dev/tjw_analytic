import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tjw_analytics_new/ui/views/dashboard/dashboard_screen.dart';






import '../../../core/model/user_model.dart';
import '../../../services/secure_storage_service.dart';
import '../createAccount/createAccount_screen.dart';



class SplashController extends GetxController {
  var userModel = <UserModel>[].obs;
  var isLoading = true.obs;

  // Form controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final genderController = TextEditingController();
  final fruitController = TextEditingController();
  final emailController = TextEditingController();

  // Form key & focus nodes
  final formKey = GlobalKey<FormState>();
  final focusNode = FocusNode();
  final focusNodePhone = FocusNode();
  final focusNodeEmail = FocusNode();
  final focusNodePassword = FocusNode();

  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    print("INSIDE INIT SPLASH CONTROLLER");

    await Future.delayed(const Duration(seconds: 2));

    // Read login state from secure storage
    final isLoggedIn = await SecureStorageService().read("isLoggedIn");

    if (isLoggedIn == "true") {
      /// User already logged in → Go to Dashboard
      Get.off(() => DashboardScreen());
    } else {
      /// User not logged in → Ask them to login/create account
      Get.off(() => CreateAccountScreen());
    }
  }


}


