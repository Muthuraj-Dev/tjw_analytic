import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExhibitorListController extends GetxController {

  var isLoading = false.obs;

  Future<bool> refreshRemoteConfig() async {
    try {
      // await fetchWalkIns();
      return true;
    } catch (e) {
      debugPrint('Failed to refresh === remote config: $e');
      return false;
    }
  }

  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();


}
