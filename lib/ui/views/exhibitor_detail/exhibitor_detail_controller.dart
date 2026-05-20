import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tjw_analytics_new/core/model/exhibitorList.dart';
import 'package:tjw_analytics_new/core/res/colors.dart';
import 'package:toastification/toastification.dart';

import '../../../services/api_base_service.dart';
import '../../../services/request_method.dart';
import '../../controller/eventController.dart';
import '../dashboard/dashboard_controller.dart';

class ExhibitorDetailController extends GetxController {
  var isLoading = false.obs;

  final formKey = GlobalKey<FormState>();

  Future<bool> refreshRemoteConfig() async {
    try {
      // await fetchWalkIns();
      return true;
    } catch (e) {
      debugPrint('Failed to refresh === remote config: $e');
      return false;
    }
  }

  int totalFoodCount = 0;

  void init(ExhibitorListData item) {
    totalFoodCount = int.parse(item.additionalFoodcoupon!);
  }

  final eventController = Get.find<EventController>();

  var eventId = 0;

  @override
  void onInit() {
    super.onInit();
    print("TSSSS");
    /// ✅ listen to event changes
    ever(eventController.selectedEvent, (event) {
      if (event != null) {
        eventId = event.eventID ?? 0;
      }
    });

    /// ✅ initial load (if already selected)
    final event = eventController.selectedEvent.value;
    if (event != null) {
      eventId = event.eventID ?? 0;
    }

  }


  TextEditingController addFoodCouponController = TextEditingController();
  FocusNode addFoodCouponFocusNode = FocusNode();

  Future<void> saveDetail(BuildContext context, ExhibitorListData item) async {
    if (formKey.currentState?.validate() != true) {
      print('Form is invalid. Please correct the errors.');
      return;
    }

    try {
      isLoading(true);

      // ------------------------------------------------------
      // 1️⃣ FETCH LATEST DATA FROM API
      // ------------------------------------------------------
      final ExhibitorList latestResponse = await ApiBaseService.request<ExhibitorList>(
        '/Query/ExhibitorsList?EventId=$eventId',
        method: RequestMethod.GET,
        authenticated: false,
      );

      if (latestResponse.response?.status != "200" || latestResponse.data == null) {
        throw "Failed to fetch latest exhibitor list";
      }

      // Find the updated exhibitor from the fetched list
      final latestItem = latestResponse.data!
          .firstWhere((e) => e.exhibitorID == item.exhibitorID, orElse: () => item);

      // Fallback: if not found, use old item
      final latestCoupon = int.tryParse(latestItem.additionalFoodcoupon ?? "0") ?? 0;

      // ------------------------------------------------------
      // 2️⃣ CALCULATE NEW TOTAL
      // ------------------------------------------------------
      final addValue = int.tryParse(addFoodCouponController.text) ?? 0;

      totalFoodCount = latestCoupon + addValue;

      print("Latest coupon = $latestCoupon");
      print("Add value = $addValue");
      print("Final total = $totalFoodCount");

      // ------------------------------------------------------
      // 3️⃣ SAVE DATA
      // ------------------------------------------------------
      final bodyData = {
        "event_ID": item.eventID!,
        "exhibitor_ID": item.exhibitorID,
        "additionalCoupon": totalFoodCount
      };

      final Map<String, dynamic> saveResponse =
      await ApiBaseService.request<Map<String, dynamic>>(
        '/Query/SaveAdditionalFoodCoupon',
        body: bodyData,
        method: RequestMethod.POST,
        authenticated: false,
      );

      if (saveResponse['status'] == "200") {
        addFoodCouponController.clear();
        Fluttertoast.showToast(msg: saveResponse['message'] ?? "Saved");

        // SUCCESS POPUP
        showDimmedDialog(context, message: 'Food Coupon Added Successfully');
      } else {
        totalFoodCount = latestCoupon; // restore old value
      }

    } catch (e) {
      print('Error: $e');
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading(false);
    }
  }



  void showDimmedDialog(
      BuildContext context, {
        String title = 'Added',
        String message = 'Saved Successfully',
        IconData icon = Icons.check_circle,
        Color iconColor = AppColor.primary,
      }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false, // <-- outside tap disabled
      barrierLabel: '',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 250),

      pageBuilder: (ctx, a1, a2) {
        return Stack(
          children: [
            // DIM BACKGROUND (NO TAP ACTION)
            Positioned.fill(
              child: Container(color: Colors.transparent),
            ),

            Align(
              alignment: const Alignment(0, -0.65),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 280,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(icon, color: iconColor, size: 48),
                      const SizedBox(height: 16),

                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 10),

                      Text(
                        message,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();

                            final dashboardController =
                            Get.find<DashboardController>();

                            dashboardController
                                .navigatorKeys[4]
                                .currentState
                                ?.pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: iconColor,
                            foregroundColor: Colors.white,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text("Done"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },

      transitionBuilder: (_, anim, __, child) {
        return FadeTransition(opacity: anim, child: child);
      },
    );
  }


}
