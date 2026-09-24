import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tjw_analytics_new/core/model/preRegistrationResponse.dart';
import 'package:tjw_analytics_new/core/model/walkInResponse.dart';
import 'package:tjw_analytics_new/services/api_base_service.dart';
import 'package:tjw_analytics_new/services/request_method.dart';

import '../../controller/eventController.dart';

class PreRegisterController extends GetxController{

  var isLoading = false.obs;

  final eventController = Get.find<EventController>();

  var eventId = 0;

  @override
  void onInit() {
    // TODO: implement onInit


    /// ✅ listen to event changes
    ever(eventController.selectedEvent, (event) {
      if (event != null) {
        eventId = event.eventID ?? 0;
        fetchWalkIns();
      }
    });

    /// ✅ initial load (if already selected)
    final event = eventController.selectedEvent.value;
    if (event != null) {
      eventId = event.eventID ?? 0;
      fetchWalkIns();
    }

    // fetchWalkIns();
    super.onInit();
  }

  final Map<String, String> labelIcons = {
    "Total": "assets/total1.svg",
    "TV": "assets/member.svg",
    "PV": "assets/member.svg",
    "SI": "assets/member.svg",
    "MM": "assets/member.svg",
    "EX": "assets/member.svg",
    "OB": "assets/member.svg",
    "AR": "assets/member.svg",
    "PR": "assets/member.svg",
    "CV": "assets/member.svg",
    "EM": "assets/member.svg",
    "ST": "assets/member.svg",
    "CM": "assets/member.svg",
    "VIP": "assets/member.svg",
  };

  final apiData = <Map<String, dynamic>>[].obs;
  final lastUpdated = Rxn<DateTime>();

  Future<void> fetchWalkIns() async {
    try {
      isLoading(true);

      final PreRegistrationResponse response =
      await ApiBaseService.request<PreRegistrationResponse>(
        '/Query/PreRegistration?EventId=$eventId',
        method: RequestMethod.GET,
        authenticated: false,
      );

      if (response.response?.status == "200" && response.data != null) {
        final mapped = response.data!.map<Map<String, dynamic>>((item) {
          return {
            "label": item.label ?? "",
            "totalCount": item.totalCount ?? 0,
            // "day2": item.day2 ?? 0,
            // "day3": item.day3 ?? 0,
          };
        }).toList();

        // ✅ move EX rows to the bottom
        final exRows = mapped.where((e) => e["label"] == "EX").toList();
        final otherRows = mapped.where((e) => e["label"] != "EX").toList();

        apiData.assignAll([...otherRows, ...exRows]);
        lastUpdated.value = DateTime.now();
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading(false);
    }
  }


  Future<bool> refreshRemoteConfig() async {
    try {
      await fetchWalkIns();
      return true;
    } catch (e) {
      debugPrint('Failed to refresh === remote config: $e');
      return false;
    }
  }


}