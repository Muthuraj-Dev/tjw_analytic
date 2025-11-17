import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ExhibitorDetailController extends GetxController{


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

  TextEditingController addFoodCouponController = TextEditingController();
  FocusNode addFoodCouponFocusNode = FocusNode();


}