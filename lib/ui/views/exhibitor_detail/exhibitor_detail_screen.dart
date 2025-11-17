import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tjw_analytics_new/common_widget/common_button.dart';

import '../../../common_widget/common_text_field.dart';
import '../../../core/res/colors.dart';
import '../dashboard/dashboard_controller.dart';
import 'exhibitor_detail_controller.dart';

class ExhibitorDetailScreen extends StatefulWidget {
  const ExhibitorDetailScreen({super.key});

  @override
  State<ExhibitorDetailScreen> createState() => _ExhibitorDetailScreenState();
}

class _ExhibitorDetailScreenState extends State<ExhibitorDetailScreen> {
  final ExhibitorDetailController controller = Get.put(
    ExhibitorDetailController(),
  );

  Future<void> _onRefresh(BuildContext context) async {
    bool refreshed = await controller.refreshRemoteConfig();
    if (refreshed) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Updated!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          onRefresh: () => _onRefresh(context),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/exhibitorMenuIcon.svg",
                          height: 35,
                          color: AppColor.green,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Exhibitor Details",
                          style: TextStyle(
                            fontSize: 32,
                            color: Color(0xFF1B672B),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.green),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColor.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/exhibitorMenuIcon.svg",
                                  height: 25,
                                  color: AppColor.white,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Ashirwad Jewellers",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: AppColor.white,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColor.green,
                                width: 1,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 60,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Area",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.green,
                                  ),
                                ),
                                Text(
                                  "27 sqm",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColor.green,
                                width: 1,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 60,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Stall No",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.green,
                                  ),
                                ),
                                Text(
                                  "A11",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColor.green,
                                width: 1,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 60,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Food Coupon",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.green,
                                  ),
                                ),
                                Text(
                                  "9",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColor.green,
                                width: 1,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 60,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Food Coupon Issued",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.green,
                                  ),
                                ),
                                Text(
                                  "2",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.green),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            "Add Food Coupon",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 20),

                          CommonTextField(
                            controller: controller.addFoodCouponController,
                            focusNode: controller.addFoodCouponFocusNode,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            hintText: "Enter Food Coupon Count",
                            fillColor: AppColor.white,
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 22,
                            ),
                          ),
                          SizedBox(height: 10),
                          CommonButton(
                            text: "Submit",
                            onPressed: () {},
                            prefixIcon: SvgPicture.asset("assets/tick.svg")
                          ),
                          SizedBox(height: 10),
                          CommonButton(
                            text: "Cancel",
                            onPressed: () {
                              final dashboardController = Get.find<DashboardController>();
                              dashboardController.navigatorKeys[4].currentState?.pop();
                            },
                            isOutlined: true,
                            outlineColor: AppColor.green,
                            isFilled: false,
                            prefixIcon: Icon(Icons.cancel_outlined, size: 24),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
