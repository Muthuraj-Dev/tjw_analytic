import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/eventController.dart';

class FoodController extends GetxController{

  var isLoading = false.obs;

  final apiData = <Map<String, dynamic>>[].obs;

  final eventController = Get.find<EventController>();
  var eventId = 0;

  Future<bool> refreshRemoteConfig() async {
    try {
      // await fetchWalkIns();
      return true;
    } catch (e) {
      debugPrint('Failed to refresh === remote config: $e');
      return false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    /// ✅ listen to event changes
    ever(eventController.selectedEvent, (event) {
      if (event != null) {
        eventId = event.eventID ?? 0;
        // fetchWalkIns();
      }
    });

    /// ✅ initial load (if already selected)
    final event = eventController.selectedEvent.value;
    if (event != null) {
      eventId = event.eventID ?? 0;
      // fetchWalkIns();
    }
  }

  // Future<void> fetchWalkIns() async {
  //   try {
  //     isLoading(true);
  //
  //     final WalkInsResponse response =
  //     await ApiBaseService.request<WalkInsResponse>(
  //       '/Query/OnSpotRegistration?EventId=$eventId',
  //       method: RequestMethod.GET,
  //       authenticated: false,
  //     );
  //
  //     if (response.response?.status == "200" && response.data != null) {
  //       final mapped =
  //       response.data!.map<Map<String, dynamic>>((item) {
  //         return {
  //           "label": item.label ?? "",
  //           "day1": item.day1 ?? 0,
  //           "day2": item.day2 ?? 0,
  //           "day3": item.day3 ?? 0,
  //         };
  //       }).toList();
  //
  //       // ✅ move EX rows to the bottom
  //       final exRows = mapped.where((e) => e["label"] == "EX").toList();
  //       final otherRows = mapped.where((e) => e["label"] != "EX").toList();
  //
  //       apiData.assignAll([...otherRows, ...exRows]);
  //       lastUpdated.value = DateTime.now();
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     Get.snackbar("Error", "Something went wrong");
  //   } finally {
  //     isLoading(false);
  //   }
  // }




}