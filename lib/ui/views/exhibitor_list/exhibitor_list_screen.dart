// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:tjw_analytics_new/common_widget/common_text_field.dart';
// import 'package:tjw_analytics_new/core/res/colors.dart';
// import '../dashboard/dashboard_controller.dart';
// import '../exhibitor_detail/exhibitor_detail_screen.dart';
// import 'exhibitor_list_controller.dart';
//
// class ExhibitorListScreen extends StatefulWidget {
//   const ExhibitorListScreen({super.key});
//
//   @override
//   State<ExhibitorListScreen> createState() => _ExhibitorListScreenState();
// }
//
// class _ExhibitorListScreenState extends State<ExhibitorListScreen> {
//   final ExhibitorListController controller = Get.put(ExhibitorListController());
//
//   Future<void> _onRefresh(BuildContext context) async {
//     bool refreshed = await controller.refreshRemoteConfig();
//     if (refreshed) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('Updated!')));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.background,
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         return RefreshIndicator(
//           onRefresh: () => _onRefresh(context),
//           child: SingleChildScrollView(
//             physics: const AlwaysScrollableScrollPhysics(),
//             child: SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 10,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: 12),
//                     Row(
//                       children: [
//                         SvgPicture.asset(
//                           "assets/exhibitorMenuIcon.svg",
//                           height: 35,
//                           color: AppColor.green,
//                         ),
//                         SizedBox(width: 10),
//                         Text(
//                           "Exhibitor List",
//                           style: TextStyle(
//                             fontSize: 32,
//                             color: Color(0xFF1B672B),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 16),
//                     CommonTextField(
//                       controller: controller.searchController,
//                       focusNode: controller.searchFocusNode,
//                       borderRadius: BorderRadius.circular(60),
//                       borderColor: AppColor.green.withValues(alpha: 0.6),
//                       contentPadding: const EdgeInsets.symmetric(
//                         vertical: 12,
//                         horizontal: 16,
//                       ),
//                       prefixIcon: Icon(Icons.search_rounded, size: 30),
//                       hintText: "Enter Stall No/Company Name",
//                     ),
//                     SizedBox(height: 16),
//                     Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(color: AppColor.green),
//                         borderRadius: BorderRadius.circular(18),
//                       ),
//                       padding: EdgeInsets.all(10),
//                       child: Column(
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                               color: AppColor.green,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             padding: EdgeInsets.all(8),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Row(
//                                   children: [
//                                     SvgPicture.asset("assets/stallName.svg"),
//                                     SizedBox(width: 4),
//                                     Text(
//                                       "Stall Name",
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 16,
//                                         color: AppColor.white,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     SvgPicture.asset("assets/stallNo.svg"),
//                                     SizedBox(width: 4),
//                                     Text(
//                                       "Stall No",
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 16,
//                                         color: AppColor.white,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//
//                           SizedBox(height: 10),
//                           InkWell(
//                             onTap: () {
//                               final dashboardController =
//                                   Get.find<DashboardController>();
//                               dashboardController.navigatorKeys[4].currentState
//                                   ?.push(
//                                     MaterialPageRoute(
//                                       builder: (_) => ExhibitorDetailScreen(),
//                                     ),
//                                   );
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: AppColor.white,
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(
//                                   color: AppColor.green,
//                                   width: 1,
//                                 ),
//                               ),
//                               padding: EdgeInsets.all(8),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                 children: [
//                                   Text(
//                                     "Ashirwad Jewellers",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: AppColor.green,
//                                       decoration: TextDecoration.underline,
//                                     ),
//                                   ),
//                                   Text(
//                                     "A11",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: AppColor.green,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: AppColor.white,
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(
//                                 color: AppColor.green,
//                                 width: 1,
//                               ),
//                             ),
//                             padding: EdgeInsets.all(8),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Text(
//                                   "Ashirwad Jewellers",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: AppColor.green,
//                                     decoration: TextDecoration.underline,
//                                   ),
//                                 ),
//                                 Text(
//                                   "A11",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: AppColor.green,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: AppColor.white,
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(
//                                 color: AppColor.green,
//                                 width: 1,
//                               ),
//                             ),
//                             padding: EdgeInsets.all(8),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Text(
//                                   "Ashirwad Jewellers",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: AppColor.green,
//                                     decoration: TextDecoration.underline,
//                                   ),
//                                 ),
//                                 Text(
//                                   "A11",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: AppColor.green,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: AppColor.white,
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(
//                                 color: AppColor.green,
//                                 width: 1,
//                               ),
//                             ),
//                             padding: EdgeInsets.all(8),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Text(
//                                   "Ashirwad Jewellers",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: AppColor.green,
//                                     decoration: TextDecoration.underline,
//                                   ),
//                                 ),
//                                 Text(
//                                   "A11",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: AppColor.green,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: AppColor.white,
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(
//                                 color: AppColor.green,
//                                 width: 1,
//                               ),
//                             ),
//                             padding: EdgeInsets.all(8),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Text(
//                                   "Ashirwad Jewellers",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: AppColor.green,
//                                     decoration: TextDecoration.underline,
//                                   ),
//                                 ),
//                                 Text(
//                                   "A11",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: AppColor.green,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: AppColor.white,
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(
//                                 color: AppColor.green,
//                                 width: 1,
//                               ),
//                             ),
//                             padding: EdgeInsets.all(8),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Text(
//                                   "Ashirwad Jewellers",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: AppColor.green,
//                                     decoration: TextDecoration.underline,
//                                   ),
//                                 ),
//                                 Text(
//                                   "A11",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: AppColor.green,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: AppColor.white,
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(
//                                 color: AppColor.green,
//                                 width: 1,
//                               ),
//                             ),
//                             padding: EdgeInsets.all(8),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Text(
//                                   "Ashirwad Jewellers",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: AppColor.green,
//                                     decoration: TextDecoration.underline,
//                                   ),
//                                 ),
//                                 Text(
//                                   "A11",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: AppColor.green,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: AppColor.white,
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(
//                                 color: AppColor.green,
//                                 width: 1,
//                               ),
//                             ),
//                             padding: EdgeInsets.all(8),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Text(
//                                   "Ashirwad Jewellers",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: AppColor.green,
//                                     decoration: TextDecoration.underline,
//                                   ),
//                                 ),
//                                 Text(
//                                   "A11",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: AppColor.green,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: AppColor.white,
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(
//                                 color: AppColor.green,
//                                 width: 1,
//                               ),
//                             ),
//                             padding: EdgeInsets.all(8),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Text(
//                                   "Ashirwad Jewellers",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: AppColor.green,
//                                     decoration: TextDecoration.underline,
//                                   ),
//                                 ),
//                                 Text(
//                                   "A11",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: AppColor.green,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: AppColor.white,
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(
//                                 color: AppColor.green,
//                                 width: 1,
//                               ),
//                             ),
//                             padding: EdgeInsets.all(8),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Text(
//                                   "Ashirwad Jewellers",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: AppColor.green,
//                                     decoration: TextDecoration.underline,
//                                   ),
//                                 ),
//                                 Text(
//                                   "A11",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: AppColor.green,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: AppColor.white,
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(
//                                 color: AppColor.green,
//                                 width: 1,
//                               ),
//                             ),
//                             padding: EdgeInsets.all(8),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Text(
//                                   "Ashirwad Jewellers",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: AppColor.green,
//                                     decoration: TextDecoration.underline,
//                                   ),
//                                 ),
//                                 Text(
//                                   "A11",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: AppColor.green,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: AppColor.white,
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(
//                                 color: AppColor.green,
//                                 width: 1,
//                               ),
//                             ),
//                             padding: EdgeInsets.all(8),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Text(
//                                   "Ashirwad Jewellers",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: AppColor.green,
//                                     decoration: TextDecoration.underline,
//                                   ),
//                                 ),
//                                 Text(
//                                   "A11",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: AppColor.green,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     SizedBox(height: 8),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tjw_analytics_new/common_widget/common_text_field.dart';
import 'package:tjw_analytics_new/core/res/colors.dart';
import '../dashboard/dashboard_controller.dart';
import '../exhibitor_detail/exhibitor_detail_screen.dart';
import 'exhibitor_list_controller.dart';

class ExhibitorListScreen extends StatefulWidget {
  const ExhibitorListScreen({super.key});

  @override
  State<ExhibitorListScreen> createState() => _ExhibitorListScreenState();
}

class _ExhibitorListScreenState extends State<ExhibitorListScreen> {
  final ExhibitorListController controller = Get.put(ExhibitorListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// HEADER
                SizedBox(height: 12,),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/exhibitor1.svg",
                      height: 35,
                      color: AppColor.green,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Exhibitor List",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1B672B),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                /// SEARCH FIELD
                CommonTextField(
                  controller: controller.searchController,
                  focusNode: controller.searchFocusNode,
                  borderRadius: BorderRadius.circular(60),
                  borderColor: AppColor.green.withOpacity(0.6),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  prefixIcon: const Icon(Icons.search_rounded, size: 30),
                  hintText: "Enter Stall No / Company Name",
                ),

                const SizedBox(height: 16),

                /// TABLE HEADER
                Expanded (
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.green),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    padding: const EdgeInsets.only(
                      top: 12,
                      right: 12,
                      left: 12,
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColor.green,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _tableHeader(
                                "Stall Name",
                                "assets/stallName.svg",
                              ),
                              _tableHeader("Stall No", "assets/stallNo.svg"),
                            ],
                          ),
                        ),

                        // PAGINATION FLOW :

                        Obx(() {
                          if (controller.filteredList.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.all(20),
                              child: Center(
                                child: Text(
                                  "No Exhibitors Found",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: AppColor.green,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            );
                          }

                          return Expanded (
                            child: ListView.builder(
                         //     controller: controller.scrollController,
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(top: 10),
                              itemCount: controller.filteredList.length,
                              itemBuilder: (_, index) {
                                if (index < controller.filteredList.length) {
                                  final item = controller.filteredList[index];
                                  return _exhibitorTile(item);
                                }

                                // Pagination Loader
                                return const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: Center(child: CircularProgressIndicator()),
                                );
                              },
                            ),
                          );
                        })

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _tableHeader(String title, String icon) {
    return Row(
      children: [
        SvgPicture.asset(icon),
        const SizedBox(width: 4),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _exhibitorTile(item) {
    return InkWell(
      onTap: () {
        final dashboardController = Get.find<DashboardController>();
        dashboardController.navigatorKeys[4].currentState?.push(
          MaterialPageRoute(builder: (_) => ExhibitorDetailScreen(item: item)),
        ).then((val){
          print("BACKED NOW");
          controller.loadExhibitorList();
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 40,
          right: 20,
        ),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColor.green, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded (
              child: Text(
                item.exhibitingCompany,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColor.green,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(width: 10,),
            Row(
              children: [
                Text(
                  item.stallNumber,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColor.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 30),
                Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: AppColor.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ExhibitorModel {
  final String stallName;
  final String stallNo;

  ExhibitorModel({required this.stallName, required this.stallNo});

  factory ExhibitorModel.fromJson(Map<String, dynamic> json) {
    return ExhibitorModel(
      stallName: json["stallName"] ?? "",
      stallNo: json["stallNo"] ?? "",
    );
  }
}
