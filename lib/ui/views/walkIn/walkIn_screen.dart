import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tjw_analytics_new/ui/views/total/total_screen.dart';
import '../../../common_widget/common_button.dart';
import '../../../core/res/colors.dart';
import '../dashboard/dashboard_controller.dart';
import '../exhibitor_detail/exhibitor_detail_screen.dart';
import 'walkIn_controller.dart';

class WalkInScreen extends StatefulWidget {
  const WalkInScreen({super.key});

  @override
  State<WalkInScreen> createState() => _WalkInScreenState();
}

class _WalkInScreenState extends State<WalkInScreen> {
  final WalkInController controller = Get.put(WalkInController());

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
                        SvgPicture.asset("assets/walk-in.svg", height: 35),
                        SizedBox(width: 10),
                        Text(
                          "Walk-Ins",
                          style: TextStyle(
                            fontSize: 32,
                            color: Color(0xFF1B672B),
                          ),
                        ),
                        Spacer(),
                        InkWell (
                          onTap: (){
                            final dashboardController = Get.find<DashboardController>();
                            dashboardController.navigatorKeys[0].currentState?.push(
                              MaterialPageRoute(builder: (_) => TotalScreen()),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColor.green,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 30,vertical: 6),
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/total.svg",color: AppColor.white,),
                                SizedBox(width: 10,),
                                Text("Total",style: TextStyle(fontSize: 20,color: AppColor.white),)
                              ],
                            ),
                          ),
                        )




                      ],
                    ),

                    SizedBox(height: 16),
                    Row(
                      children: [
                        formatted != null
                            ? Icon(Icons.access_time_outlined)
                            : SizedBox.shrink(),
                        SizedBox(width: 6),
                        formatted != null
                            ? Text(
                              "Updated at:",
                              style: TextStyle(fontSize: 16),
                            )
                            : SizedBox.shrink(),
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
                              style: TextStyle(fontWeight: FontWeight.w500),
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
                            border: TableBorder.all(color: Colors.transparent),
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            children: [
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
                                              .apiData[i]['label']]!,
                                          //     color: i == controller.apiData.length - 1 ? AppColor.green : AppColor.green,
                                          color: AppColor.green,
                                          height: 30,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          controller.apiData[i]['label'],
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: controller.apiData[i]['label'] == "Total" || i == controller.apiData.length - 1  ? FontWeight.w800 : FontWeight.w400,
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
      }),
    );
  }

  TableRow _buildRow(
    List<dynamic> cells, {
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
                              fontWeight: FontWeight.normal,
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
                      //     fontWeight:
                      //         footer ? FontWeight.bold : FontWeight.w500,
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
                                  : FontWeight.w400,
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
