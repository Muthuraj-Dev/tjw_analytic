import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:tjw_analytics_new/core/model/walkInResponse.dart';
import 'package:tjw_analytics_new/services/api_base_service.dart';
import 'package:tjw_analytics_new/services/request_method.dart';

import '../../../core/model/preRegistrationResponse.dart';

class TotalController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  var isLoading = false.obs;

  int _selectedIndex = 0;

  @override
  void onInit() {
    super.onInit();
    // 👇 initialize tab controller with number of tabs
    tabController = TabController(length: 8, vsync: this);

    tabController.addListener(() {
      if (tabController.indexIsChanging == false) {
        _selectedIndex = tabController.index;
      }
    });
    fetchWalkIns();
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
        '/Query/OverAllRegistration?EventId=23',
        method: RequestMethod.GET,
        authenticated: false,
      );

      if (response.response?.status == "200" && response.data != null) {
        final mapped =
        response.data!.map<Map<String, dynamic>>((item) {
          return {
            "label": item.label ?? "",
            "totalCount": item.totalCount ?? 0,
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

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
