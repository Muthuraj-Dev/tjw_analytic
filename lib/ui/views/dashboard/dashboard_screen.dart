// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:tjw_analytics_new/ui/views/exhibitor_list/exhibitor_list_screen.dart';
// import 'package:tjw_analytics_new/ui/views/onSpot/onSpot_screen.dart';
// import 'package:tjw_analytics_new/ui/views/total/total_screen.dart';
// import '../../../core/res/colors.dart';
// import '../preRegister/preRegister_screen.dart';
// import '../walkIn/walkIn_screen.dart';
// import 'dashboard_controller.dart';
//
// class DashboardScreen extends StatelessWidget {
//   DashboardScreen({super.key});
//
//   // Initialize the controller
//   final DashboardController controller = Get.put(DashboardController());
//
//   // Define your screens for each tab here
//   static final List<Widget> _widgetOptions = <Widget>[
//     const WalkInScreen(),
//     const PreRegister(),
//     const OnSpotScreen(),
//     const TotalScreen(),
//     const ExhibitorListScreen(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.white,
//       extendBodyBehindAppBar: false,
//
//       // extendBodyBehindAppBar:
//       //     controller.selectedIndex.value == 0 ? true : false,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(38), // Increase AppBar height
//
//         child: Obx(() {
//           bool isHome = controller.selectedIndex.value == 0;
//           return AppBar(
//             elevation: 0,
//             backgroundColor: AppColor.background,
//
//             flexibleSpace: Padding(
//               padding: const EdgeInsets.only(top: 50, left: 14, right: 14),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Image.asset(
//                       'assets/app_logo.png',
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//
//                   Row(
//                     children: [
//                       SvgPicture.asset("assets/profileIcon.svg", height: 25),
//                       SizedBox(width: 6),
//                       Obx(() {
//                         return Text(
//                           controller.userName.value,
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xff27933E),
//                           ),
//                         );
//                       }),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }),
//       ),
//       body: Obx(() {
//         return _widgetOptions.elementAt(controller.selectedIndex.value);
//       }),
//       bottomNavigationBar: Obx(() {
//         final isHome = controller.selectedIndex.value == 0;
//
//         return BottomNavigationBar(
//           type: BottomNavigationBarType.fixed,
//           backgroundColor: AppColor.background,
//           selectedItemColor: AppColor.green,
//           unselectedItemColor: AppColor.green,
//           currentIndex: controller.selectedIndex.value,
//           onTap: controller.onItemTapped,
//           elevation: 0,
//           items: [
//             BottomNavigationBarItem(
//               icon: SvgPicture.asset(
//                 "assets/walk-in.svg",
//                 height: 30,
//                 color:
//                     controller.selectedIndex.value == 0
//                         ? AppColor.green
//                         : Colors.black45,
//               ),
//               label: 'Walk-Ins',
//             ),
//             BottomNavigationBarItem(
//               icon: SvgPicture.asset(
//                 "assets/pre-reg.svg",
//                 height: 30,
//                 color:
//                     controller.selectedIndex.value == 1
//                         ? AppColor.green
//                         : Colors.black45,
//               ),
//               label: 'Pre-Reg',
//             ),
//             BottomNavigationBarItem(
//               icon: SvgPicture.asset(
//                 "assets/onSpot.svg",
//                 height: 30,
//                 color:
//                     controller.selectedIndex.value == 2
//                         ? AppColor.green
//                         : Colors.black45,
//               ),
//               label: 'On-Spot',
//             ),
//             BottomNavigationBarItem(
//               icon: SvgPicture.asset(
//                 "assets/total.svg",
//                 height: 30,
//                 color:
//                     controller.selectedIndex.value == 3
//                         ? AppColor.green
//                         : Colors.black45,
//               ),
//               label: 'Coupon',
//             ),
//             BottomNavigationBarItem(
//               icon: SvgPicture.asset(
//                 "assets/exhibitorMenuIcon.svg",
//                 height: 30,
//                 color:
//                 controller.selectedIndex.value == 3
//                     ? AppColor.green
//                     : Colors.black45,
//               ),
//               label: 'Ex-List',
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tjw_analytics_new/ui/views/exhibitor_list/exhibitor_list_screen.dart';
import 'package:tjw_analytics_new/ui/views/onSpot/onSpot_screen.dart';
import 'package:tjw_analytics_new/ui/views/total/total_screen.dart';
import '../../../core/res/colors.dart';
import '../food/food_screen.dart';
import '../preRegister/preRegister_screen.dart';
import '../walkIn/walkIn_screen.dart';
import 'dashboard_controller.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  var selectedIndex = 0.obs;

  final DashboardController controller = Get.put(DashboardController());

  // Each tab’s root widget wrapped with Navigator
  List<Widget> _buildNavigators() => [
    _buildTabNavigator(0, const WalkInScreen()),
    _buildTabNavigator(1, const OnSpotScreen()),
    _buildTabNavigator(2, const PreRegister()),
    _buildTabNavigator(3, const FoodScreen()),
    _buildTabNavigator(4, const ExhibitorListScreen()),
  ];

  // Builds a Navigator for each tab
  Widget _buildTabNavigator(int index, Widget child) {
    return Navigator(
      key: controller.navigatorKeys[index],
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (_) => child);
      },
    );
  }

  Future<bool> _onWillPop() async {
    final currentNavigator =
        controller.navigatorKeys[controller.selectedIndex.value].currentState!;
    if (currentNavigator.canPop()) {
      currentNavigator.pop();
      return false;
    }
    return true; // exit app if at root
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Obx(() {
        return Scaffold(
          backgroundColor: AppColor.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              elevation: 0,
              backgroundColor: AppColor.background,
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(
                  top: 50,
                  left: 14,
                  right: 14,
                  bottom: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/app_logo.png', fit: BoxFit.contain),
                    InkWell(
                      onTap: () {
                        print("Logout Session Handle Here");
                       controller.showLogoutDialog(context);

                        // Get.defaultDialog(
                        //   title: "Logout",
                        //   middleText: "Are you sure you want to logout?",
                        //   textCancel: "Cancel",
                        //   textConfirm: "Logout",
                        //   confirmTextColor: Colors.white,
                        //   onConfirm: () async {
                        //     await controller.logout();
                        //     Get.back(); // close dialog
                        //   },
                        // );
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/profileIcon.svg",
                            height: 25,
                          ),
                          const SizedBox(width: 6),
                          Obx(() {
                            return Text(
                              controller.userName.value,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff27933E),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ✅ Keep all navigators alive but show only current one
          body: IndexedStack(
            index: controller.selectedIndex.value,
            children: _buildNavigators(),
          ),

          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColor.background,
            selectedItemColor: AppColor.green,
            unselectedItemColor: Colors.black45,
            currentIndex: controller.selectedIndex.value,
            onTap: (index) {
              // If tapping same tab → pop to root
              if (index == controller.selectedIndex.value) {
                controller.navigatorKeys[index].currentState?.popUntil(
                  (r) => r.isFirst,
                );
              } else {
                controller.onItemTapped(index);
              }
            },
            elevation: 0,
            items: [
              _navItem("assets/walk-in.svg", 'Walk-Ins', 0),
              _navItem("assets/onSpot.svg", 'On-Spot', 1),
              _navItem("assets/pre-reg.svg", 'Pre-Reg', 2),
              _navItem("assets/food_coupon.svg", 'Food', 3),
              _navItem("assets/exhibitorMenuIcon.svg", 'Ex-List', 4),
            ],
          ),
        );
      }),
    );
  }

  BottomNavigationBarItem _navItem(String icon, String label, int index) {
    final isSelected = controller.selectedIndex.value == index;
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        icon,
        height: 30,
        color: isSelected ? AppColor.green : Colors.black45,
      ),
      label: label,
    );
  }
}
