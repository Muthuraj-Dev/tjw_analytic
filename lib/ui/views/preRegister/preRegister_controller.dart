import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tjw_analytics_new/core/model/preRegistrationResponse.dart';
import 'package:tjw_analytics_new/core/model/walkInResponse.dart';
import 'package:tjw_analytics_new/services/api_base_service.dart';
import 'package:tjw_analytics_new/services/request_method.dart';

class PreRegisterController extends GetxController{
  final List<Map<String, dynamic>> eventList = [
    {
      'image': 'assets/apgjf.png',
      'date': '15 Aug - 17 Aug',
      'time': '10 AM onwards',
      'location': 'SS Convention Centre, Vijayawada',
    },
    {
      'image': 'assets/hijs.png',
      'date': '25 Jul - 27 Jul',
      'time': '7 PM onwards',
      'location': 'Chennai trade centre, Nandambakkam, Chennai',
    },
    {
      'image': 'assets/gjif_logo.png',
      'date': '15 Aug - 17 Aug',
      'time': '10 AM onwards',
      'location': 'Bombay Exhibition Center, Mumbai',
    },

    {
      'image': 'assets/apgjf.png',
      'date': '15 Aug - 17 Aug',
      'time': '10 AM onwards',
      'location': 'SS Convention Centre, Vijayawada',
    },
    {
      'image': 'assets/hijs.png',
      'date': '25 Jul - 27 Jul',
      'time': '7 PM onwards',
      'location': 'Chennai trade centre, Nandambakkam, Chennai',
    },
    {
      'image': 'assets/gjif_logo.png',
      'date': '15 Aug - 17 Aug',
      'time': '10 AM onwards',
      'location': 'Bombay Exhibition Center, Mumbai',
    },

    {
      'image': 'assets/apgjf.png',
      'date': '15 Aug - 17 Aug',
      'time': '10 AM onwards',
      'location': 'SS Convention Centre, Vijayawada',
    },
    {
      'image': 'assets/hijs.png',
      'date': '25 Jul - 27 Jul',
      'time': '7 PM onwards',
      'location': 'Chennai trade centre, Nandambakkam, Chennai',
    },
    {
      'image': 'assets/gjif_logo.png',
      'date': '15 Aug - 17 Aug',
      'time': '10 AM onwards',
      'location': 'Bombay Exhibition Center, Mumbai',
    },

    {
      'image': 'assets/apgjf.png',
      'date': '15 Aug - 17 Aug',
      'time': '10 AM onwards',
      'location': 'SS Convention Centre, Vijayawada',
    },
    {
      'image': 'assets/hijs.png',
      'date': '25 Jul - 27 Jul',
      'time': '7 PM onwards',
      'location': 'Chennai trade centre, Nandambakkam, Chennai',
    },
    {
      'image': 'assets/gjif_logo.png',
      'date': '15 Aug - 17 Aug',
      'time': '10 AM onwards',
      'location': 'Bombay Exhibition Center, Mumbai',
    },

  ];

  var isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit

    fetchWalkIns();
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
        '/Query/PreRegistration?EventId=23',
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