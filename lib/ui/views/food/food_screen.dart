import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';

import '../../../core/res/colors.dart';
import 'food_controller.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  final FoodController controller = Get.put(FoodController());

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
        final formatted = DateTime.now() != null
            ? DateFormat('h:mm a').format(DateTime.now())
            : null;

        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          onRefresh: () => _onRefresh(context),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/food_coupon_title_icon.svg",
                          height: 36,
                          color: AppColor.primary,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Food Coupon",
                          style: TextStyle(
                            fontSize: 32,
                            color: Color(0xFF1B672B),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16),
                    Row(
                      children: [
                        formatted != null ?
                        Icon(Icons.access_time_outlined) : SizedBox.shrink(),

                        SizedBox(width: 6),
                        Text("Updated at:", style: TextStyle(fontSize: 16)),
                        formatted != null ?
                        Text(
                          formatted,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColor.green,
                          ),
                        ) : SizedBox.shrink(),
                        Spacer(),
                        Row(
                          children: [
                            Icon(Icons.refresh),
                            SizedBox(width: 6),
                            Text(
                              "Pull down to refresh",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.green),
                        borderRadius: BorderRadius.circular(18),
                        color: AppColor.green
                      ),
                      padding: EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset("assets/calender.svg",color: AppColor.white,),
                              SizedBox(width: 10,),
                              Text("Day 3 | Nov 25",style: TextStyle(color: AppColor.white,fontSize: 18),),
                            ],
                          ),
                          SizedBox(height: 30,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset("assets/food_consumed.svg",color: AppColor.white,),
                                  SizedBox(width: 10,),
                                  Text("Food Consumed",style: TextStyle(color: AppColor.white,fontSize: 18),),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("10,000 Plates",style: TextStyle(color: AppColor.white,fontSize: 18),),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 14,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset("assets/coffee.svg",color: AppColor.white,),
                                  SizedBox(width: 10,),
                                  Text("Beverage Consumed",style: TextStyle(color: AppColor.white,fontSize: 18),),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("10,000 Plates",style: TextStyle(color: AppColor.white,fontSize: 18),),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.green),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      padding: EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset("assets/calender.svg",color: AppColor.green,),
                              SizedBox(width: 10,),
                              Text("Day 2 | Nov 24",style: TextStyle(color: AppColor.green,fontSize: 18),),
                            ],
                          ),
                          SizedBox(height: 30,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset("assets/food_consumed.svg",color: AppColor.green,),
                                  SizedBox(width: 10,),
                                  Text("Food Consumed",style: TextStyle(color: AppColor.green,fontSize: 18),),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("10,000 Plates",style: TextStyle(color: AppColor.green,fontSize: 18),),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 14,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset("assets/coffee.svg",color: AppColor.green,),
                                  SizedBox(width: 10,),
                                  Text("Beverage Consumed",style: TextStyle(color: AppColor.green,fontSize: 18),),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("10,000 Plates",style: TextStyle(color: AppColor.green,fontSize: 18),),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.green),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      padding: EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset("assets/calender.svg",color: AppColor.green,),
                              SizedBox(width: 10,),
                              Text("Day 1 | Nov 23",style: TextStyle(color: AppColor.green,fontSize: 18),),
                            ],
                          ),
                          SizedBox(height: 30,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset("assets/food_consumed.svg",color: AppColor.green,),
                                  SizedBox(width: 10,),
                                  Text("Food Consumed",style: TextStyle(color: AppColor.green,fontSize: 18),),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("10,000 Plates",style: TextStyle(color: AppColor.green,fontSize: 18),),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 14,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset("assets/coffee.svg",color: AppColor.green,),
                                  SizedBox(width: 10,),
                                  Text("Beverage Consumed",style: TextStyle(color: AppColor.green,fontSize: 18),),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("10,000 Plates",style: TextStyle(color: AppColor.green,fontSize: 18),),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                    SizedBox(height: 40),
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
