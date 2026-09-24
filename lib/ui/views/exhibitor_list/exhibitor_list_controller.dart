import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tjw_analytics_new/services/request_method.dart';
import '../../../core/model/exhibitorList.dart';
import '../../../core/model/walkInResponse.dart';
import '../../../services/api_base_service.dart';
import '../../controller/eventController.dart';

class ExhibitorListController extends GetxController {
  var isLoading = false.obs;

  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();

  RxList<ExhibitorListData> exhibitors = <ExhibitorListData>[].obs;
  RxList<ExhibitorListData> filteredList = <ExhibitorListData>[].obs;

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
        loadExhibitorList();
      }
    });

    /// ✅ initial load (if already selected)
    final event = eventController.selectedEvent.value;
    if (event != null) {
      eventId = event.eventID ?? 0;
      loadExhibitorList();
    }


    searchController.addListener(_onSearchChanged);
  }

  void loadExhibitorList() async {
    exhibitors.clear();
    print("Entered Here");
    try {
      isLoading(true);
      final ExhibitorList response = await ApiBaseService.request<ExhibitorList>(
            '/Query/ExhibitorsList?EventId=$eventId',
            method: RequestMethod.GET,
            authenticated: false,
          );
      if (response.response?.status == "200" && response.data != null) {
         exhibitors.addAll(response.data!);
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading(false);
    }

    filteredList.assignAll(exhibitors);
    isLoading.value = false;
  }

  Future<void> fetchExhibitorList() async {
    try {
      isLoading(true);

      final WalkInsResponse response =
          await ApiBaseService.request<WalkInsResponse>(
            '/Query/WalkIns?EventId=$eventId',
            method: RequestMethod.GET,
            authenticated: false,
          );
      if (response.response?.status == "200" && response.data != null) {}
    } catch (e) {
      print('Error: $e');
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading(false);
    }
  }

  void _onSearchChanged() {
    String query = searchController.text.trim().toLowerCase();

    if (query.isEmpty) {
      filteredList.assignAll(exhibitors);
      return;
    }

    filteredList.value =
        exhibitors.where((item) {
          return (item.exhibitingCompany ?? '').toLowerCase().contains(query) ||
              (item.stallNumber ?? '').toLowerCase().contains(query);
        }).toList();
  }

  Future<bool> refreshRemoteConfig() async {
    try {
      // await fetchWalkIns();
      return true;
    } catch (e) {
      debugPrint('Failed to refresh === remote config: $e');
      return false;
    }
  }
}
