import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:tjw_analytics_new/ui/views/total/total_controller.dart';

import '../../../common_widget/common_button.dart';
import '../../../core/res/colors.dart';

class TotalScreen extends StatefulWidget {
  const TotalScreen({super.key});

  @override
  State<TotalScreen> createState() => _TotalScreenState();
}

class _TotalScreenState extends State<TotalScreen> {
  final TotalController controller = Get.put(TotalController());

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
        final formatted =
            controller.lastUpdated.value != null
                ? DateFormat('h:mm a').format(controller.lastUpdated.value!)
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
                          "assets/total.svg",
                          height: 30,
                          color: AppColor.primary,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 32,
                            color: Color(0xFF1B672B),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16),

                    Row(
                      children: [
                        formatted != null
                            ? Icon(Icons.access_time_outlined)
                            : SizedBox.shrink(),

                        SizedBox(width: 6),
                        Text(
                          "Updated at: ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        formatted != null
                            ? Text(
                              formatted,
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColor.green,
                              ),
                            )
                            : SizedBox.shrink(),
                        Spacer(),
                        Row(
                          children: [
                            Icon(Icons.refresh),
                            SizedBox(width: 6),
                            Text(
                              "Pull down to refresh",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 8),

                    // Container(
                    //   decoration: BoxDecoration(
                    //     border: Border.all(color: AppColor.green),
                    //     borderRadius: BorderRadius.circular(20),
                    //   ),
                    //   padding: const EdgeInsets.all(12),
                    //   child: Column(
                    //     children: [
                    //       Table(
                    //         border: TableBorder.all(color: Colors.transparent),
                    //         defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    //         columnWidths: const {
                    //           0: FlexColumnWidth(2),
                    //           1: FlexColumnWidth(),
                    //           2: FlexColumnWidth(),
                    //           3: FlexColumnWidth(),
                    //         },
                    //         children: [
                    //           _buildRow(["Category", "Total"], header: true),
                    //         ],
                    //       ),
                    //       //    const SizedBox(height: 18),
                    //       Table(
                    //         columnWidths: const {
                    //           0: FlexColumnWidth(2),
                    //           1: FlexColumnWidth(),
                    //           2: FlexColumnWidth(),
                    //           3: FlexColumnWidth(),
                    //         },
                    //         children: [
                    //           _buildRow(["Total", "Day 1"]),
                    //           _buildRow(["TV", "400"]),
                    //           _buildRow(["PV", "400"]),
                    //           _buildRow(["SI", "400"]),
                    //           _buildRow(["OR", "500"]),
                    //           _buildRow(["SM", "600"]),
                    //           _buildRow(["MM", "700"]),
                    //         ],
                    //       ),
                    //       //    const SizedBox(height: 18),
                    //       Table(
                    //         columnWidths: const {
                    //           0: FlexColumnWidth(2),
                    //           1: FlexColumnWidth(),
                    //           2: FlexColumnWidth(),
                    //           3: FlexColumnWidth(),
                    //         },
                    //         children: [
                    //           // _buildRow(["Category", "Day 1", "Day 2", "Day 3"], footer: true),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(height: 8),
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
                            border: TableBorder.all(color: Colors.transparent),
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            children: [
                              _buildRow(
                                ["Type", "Total"],
                                header: true,
                                headerIcons: {
                                  "Type": SvgPicture.asset(
                                    "assets/category.svg",
                                    height: 20,
                                  ),
                                  "Total": SvgPicture.asset(
                                    "assets/total1.svg",
                                  ),
                                },
                              ),

                              for (
                                int i = 0;
                                i < controller.apiData.length;
                                i++
                              )
                                _buildRow(
                                  [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          controller.labelIcons[controller
                                                  .apiData[i]['label']] ??
                                              "assets/category.svg",
                                          //   color: i == controller.apiData.length - 1 ? AppColor.green : AppColor.white,
                                          color: AppColor.green,
                                          height: 30,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          controller.apiData[i]['label'],
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight:
                                                controller.apiData[i]['label'] ==
                                                            "Total" ||
                                                        i ==
                                                            controller
                                                                    .apiData
                                                                    .length -
                                                                1
                                                    ? FontWeight.w800
                                                    : FontWeight.w500,
                                            color:
                                                i ==
                                                        controller
                                                                .apiData
                                                                .length -
                                                            1
                                                    ? AppColor.green
                                                    : AppColor.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                    controller.apiData[i]['totalCount']
                                        .toString(),
                                  ],
                                  footer: i == controller.apiData.length - 1,
                                  total:
                                      controller.apiData[i]['label'] == "Total",
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
      }),
    );
  }

  TableRow _buildRow(
    List<dynamic> cells, { // ✅ can be String or Widget
    bool header = false,
    bool total = false,
    bool footer = false,
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
              border: footer ? null : Border.all(color: AppColor.green),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children:
                  cells.map((cell) {
                    Widget content;

                    if (cell is Widget) {
                      // ✅ direct widget support
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
                              fontWeight: FontWeight.normal,
                              color: textColor,
                            ),
                          ),
                        ],
                      );
                    } else {
                      final text = cell.toString();
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

                    return Center(child: content);
                  }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
