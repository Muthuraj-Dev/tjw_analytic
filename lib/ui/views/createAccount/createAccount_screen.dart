
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';



import '../../../common_widget/common_button.dart';
import '../../../common_widget/common_text_field.dart';
import '../../../common_widget/tap_outside_unfocus.dart';
import '../../../core/res/colors.dart';
import 'createAccount_controller.dart';


class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final CreateAccountController controller = Get.put(CreateAccountController());


  @override
  Widget build(BuildContext context) {
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
              key: controller.formSignUp,
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 50),
                        SvgPicture.asset("assets/profile1.svg"),
                        SizedBox(height: 6),
                        Text(
                          "Login Account",
                          style: TextStyle(fontSize: 24),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            "Join us today and get started",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColor.textDisable,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 50),
                        // CommonTextField(controller: controller.nameController, focusNode: controller.nameFocus,hintText: 'Enter your name',),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Text(
                                  "+91",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: CommonTextField.phone(
                                controller: controller.phoneController,
                                focusNode: controller.phoneFocusNode,
                                fillColor: AppColor.background,
                                borderColor: AppColor.textDisable,
                                hintText: 'Enter createAccount number',
                                contentPadding: EdgeInsets.symmetric(vertical: 18,horizontal: 12),
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Please enter phone number';
                                  }
                                  RegExp phoneRegExp = RegExp(r'^[0-9]{10}$');
                                  if (!phoneRegExp.hasMatch(val)) {
                                    return 'Please enter a valid phone number';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 40),
                        Obx((){
                          return   CommonButton(
                            text: "Send Verification Code",
                            isLoading: controller.isLoading.value,
                            onPressed: () {
                              controller.submit();
                            },
                            borderRadius: BorderRadius.circular(40),
                            suffixIcon: SvgPicture.asset(
                              "assets/arrow_outward.svg",
                              color: Colors.white,
                            ),
                          );
                        })

                      ],
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
