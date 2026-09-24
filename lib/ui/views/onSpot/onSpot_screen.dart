
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../common_widget/common_button.dart';
import '../../../common_widget/common_text_field.dart';
import '../../../core/res/colors.dart';
import 'onSpot_controller.dart';


class OnSpotScreen extends StatefulWidget {
  const OnSpotScreen({super.key});

  @override
  State<OnSpotScreen> createState() => _OnSpotScreenState();
}

class _OnSpotScreenState extends State<OnSpotScreen> {
  final OnSpotController controller = Get.put(OnSpotController());

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
      body: Obx((){

        final formatted = controller.lastUpdated.value != null
            ? DateFormat('h:mm a').format(controller.lastUpdated.value!)
            : null;

        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return  RefreshIndicator (
          onRefresh: () => _onRefresh(context),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: SingleChildScrollView (
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12,),
                    Row(
                      children: [
                        SvgPicture.asset("assets/onspot_1.svg", height: 35,color: AppColor.primary,),
                        SizedBox(width: 10),
                        Text(
                          "On-Spot",
                          style: TextStyle(fontSize: 32, color: Color(0xFF1B672B,),fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        formatted != null ?
                        Icon(Icons.access_time_outlined) : SizedBox.shrink(),
                        SizedBox(width: 6),
                        formatted != null ?
                        Text("Updated at: ", style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)) : SizedBox.shrink(),
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
                              style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.green),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.only(
                        top: 12,
                        right: 12,
                        left: 12,
                      ),
                      child: Column(
                        children: [
                          Table(
                            border: TableBorder.all(
                              color: Colors.transparent,
                            ),
                            defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                            children: [
                              // ✅ Static Header Row
                              _buildRow(
                                ["Type", "Day 1", "Day 2", "Day 3"],
                                header: true,
                                headerIcons: {
                                  "Type": SvgPicture.asset(
                                    "assets/category.svg",
                                  ),
                                  "Day 1": const Icon(
                                    Icons.calendar_today,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                  "Day 2": const Icon(
                                    Icons.calendar_today,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                  "Day 3": const Icon(
                                    Icons.calendar_today,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                },
                              ),

                              // for (int i = 0; i < apiData.length; i++)
                              //   _buildRow([
                              //     Row(
                              //       children: [
                              //         SvgPicture.asset(
                              //           apiData[i]['icon'],
                              //           color:
                              //               i == apiData.length - 1
                              //                   ? AppColor
                              //                       .green // footer style for last row
                              //                   : AppColor.white,
                              //           height: 30,
                              //         ),
                              //         const SizedBox(width: 6),
                              //         Text(
                              //           apiData[i]['label'],
                              //           style: TextStyle(
                              //             fontSize: 16,
                              //             fontWeight: FontWeight.w500,
                              //             color:
                              //                 i == apiData.length - 1
                              //                     ? AppColor.green
                              //                     : Colors.white,
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //     apiData[i]['day1'].toString(),
                              //     apiData[i]['day2'].toString(),
                              //     apiData[i]['day3'].toString(),
                              //   ], footer: i == apiData.length - 1),
                              for ( int i = 0; i < controller.apiData.length; i++ )
                                _buildRow(
                                  [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          controller.labelIcons[controller
                                              .apiData[i]['label']] ??
                                              "assets/category.svg",
                                          color: AppColor.green,
                                       //   color: i == controller.apiData.length - 1 ? AppColor.green // ✅ footer style: AppColor.white,
                                          height: 30,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          controller.apiData[i]['label'],
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: controller.apiData[i]['label'] == "Total" || i == controller.apiData.length - 1  ? FontWeight.w800 : FontWeight.w500,
                                            // color:
                                            // i ==
                                            //     controller
                                            //         .apiData
                                            //         .length -
                                            //         1
                                            //     ? AppColor.green
                                            //     : Colors.white,
                                            color:
                                            i == controller.apiData.length - 1
                                                ? AppColor.green
                                                : AppColor.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                    controller.apiData[i]['day1'].toString(),
                                    controller.apiData[i]['day2'].toString(),
                                    controller.apiData[i]['day3'].toString(),
                                  ],
                                  footer: i == controller.apiData.length - 1,
                                  total: controller.apiData[i]['label'] == "Total",
                                ),
                            ],
                          ),
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
      })


    );
  }


  // TableRow _buildRow(
  //     List<String> cells, {
  //       bool header = false,
  //       bool footer = false,
  //     }) {
  //   final Color bgColor = header
  //       ? Color(0xff103B19)
  //       : footer
  //       ? Colors.transparent
  //       : AppColor.green;
  //
  //   final Color textColor = header
  //       ? Colors.white
  //       : footer
  //       ? AppColor.green
  //       : Colors.white;
  //
  //   return TableRow(
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.only(bottom: 12),
  //         child: Container(
  //           decoration: BoxDecoration(
  //             color: bgColor,
  //             border: footer ? Border.all(color: AppColor.green) : null,
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //           padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: cells
  //                 .map(
  //                   (text) => Expanded(
  //                 child: Center(
  //                   child: Text(
  //                     text,
  //                     style: TextStyle(
  //                       fontSize: header ? 18 : 16,
  //                       fontWeight:
  //                       header ? FontWeight.bold : FontWeight.w500,
  //                       color: textColor,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             )
  //                 .toList(),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  TableRow _buildRow(
      List<dynamic> cells, { // ✅ can be String or Widget
        bool header = false,
        bool footer = false,
        bool total = false,
        Map<String, Widget>? headerIcons,
      }) {
    final Color bgColor =
    header
        ? AppColor.green
        : footer
        ? Colors.transparent
        : AppColor.white;

    final Color textColor =
    header
        ? Colors.white
        : footer
        ? AppColor.green
        : AppColor.green;


    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Container(
            decoration: BoxDecoration(
              color: bgColor,
              border:
              footer
                  ? null
                  : Border.all(color: AppColor.green),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children:
              cells.map((cell) {
                Widget content;

                if (cell is Widget) {
                  content = cell;
                } else if (header) {
                  final text = cell.toString();
                  final customIcon = headerIcons?[text];

                  content = Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (customIcon != null) customIcon,
                      if (customIcon != null) const SizedBox(width: 6),
                      Text(
                        text,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: textColor,
                        ),
                      ),
                    ],
                  );
                } else {
                  final text = cell.toString();
                  // content = Text(
                  //   text,
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.w500,
                  //     color: textColor,
                  //   ),
                  // );

                  content = Text(
                    text,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                      (footer || total)
                          ? FontWeight.w800
                          : FontWeight.w500,
                      color: textColor,
                    ),
                  );
                }

                return Expanded(child: Center(child: content));
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

}
