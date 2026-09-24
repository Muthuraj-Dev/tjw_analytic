import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tjw_analytics_new/core/res/colors.dart';
import 'package:tjw_analytics_new/services/secure_storage_service.dart';

import '../../../core/model/todo_model.dart';
import '../../../core/model/user_model.dart';
import '../../../core/model/user_response.dart';
import '../../../services/api_base_service.dart';
import '../createAccount/createAccount_screen.dart';

class DashboardController extends GetxController {
  var isLoading = false.obs;  // Observable variable to track loading state
  var user = UserModel().obs;  // Observable variable for user data
  var todos = <TodoModel>[].obs;  // Observable list for todos

  List<Data> userList = [];  // List to hold user data from API
  var userName = "".obs;


  // Each tab has its own Navigator key
  final List<GlobalKey<NavigatorState>> navigatorKeys = List.generate(5,(_) => GlobalKey<NavigatorState>(),);

  // void onItemTapped(int index) {
  //   if (selectedIndex.value == index) {
  //     // If the same tab is tapped again, pop to its first route
  //     navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
  //   } else {
  //     selectedIndex.value = index;
  //   }
  // }

  void onItemTapped(int index) {
    final currentIndex = selectedIndex.value;

    // If tapping the same tab again → pop to root
    if (currentIndex == index) {
      navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
    } else {
      // Before switching tabs, pop the current tab's stack to root
      navigatorKeys[currentIndex].currentState?.popUntil((route) => route.isFirst);

      // Now switch tab
      selectedIndex.value = index;
    }
  }

  // 👇 Optional helper getter to access current tab’s navigator
  GlobalKey<NavigatorState> get currentNavigator => navigatorKeys[selectedIndex.value];


  @override
  void onInit() {
    super.onInit();
    print("INIT CALLED");
    _loadUserName();
   // fetchInitialData(); // Fetch data when controller is initialized
  }

  Future<void> _loadUserName() async {
    final storedName = await SecureStorageService().read("userName");
    userName.value = storedName ?? "";
  }


  final List<Map<String, dynamic>> items = [
    {
      "title": "Join New Plan",
      "image": "assets/new_plan.png",
    },
    {
      "title": "My Wallet",
      "image": "assets/wallet.png",
    },
    {
      "title": "Transactions",
      "image": "assets/transactions.png",
    },
  ];


  // Function to handle tab changes
  // GetX automatically updates the UI based on these changes
  var selectedIndex = 0.obs;

  // void onItemTapped(int index) {
  //   print("ONNNNNN $index");
  //   selectedIndex.value = index;  // Directly update the selected index (no setState needed)
  // }

  // Function to fetch initial data
  void fetchInitialData() async {
    isLoading(true);  // Set loading to true
    try {
      UserResponse? response = await ApiBaseService.request<UserResponse>(
        'users?page=2',
        method: 'GET',
        authenticated: true,
      );

      if (response.data!.isNotEmpty) {
        userList = response.data!;  // Update user list with fetched data
        print("======= $userList");
      } else {
        Fluttertoast.showToast(msg: 'No data found');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: $e');  // Show error toast
    } finally {
      isLoading(false);  // Set loading to false after fetching data
    }
  }

  Future<void> logout() async {
    try {
      // Delete all session-related keys
      await SecureStorageService().delete("isLoggedIn");
      await SecureStorageService().delete("mobileNumber");
      await SecureStorageService().delete("userId");
      await SecureStorageService().delete("userName");

      // Optional: Clear entire storage
      // await SecureStorageService().clearAll();

      // Reset local observable data
      userName.value = "";
      // any other fields

      // Navigate user to login/create account screen
      Get.offAll(() => CreateAccountScreen());
    } catch (e) {
      print("Logout error: $e");
    }
  }

  void showLogoutDialog(BuildContext context) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColor.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.logout,
                  size: 40,
                  color: AppColor.green,
                ),
              ),

              const SizedBox(height: 20),

              // Title
              const Text(
                "Logout",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              // Message
              const Text(
                "Are you sure you want to logout?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 25),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Cancel button
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade400),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () => Get.back(),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Logout button
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.green, // red
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () async {
                        await logout();
                        Get.back();
                      },
                      child: const Text(
                        "Logout",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


}
