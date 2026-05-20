import 'package:get/get.dart';

import '../../../core/model/event_list_model.dart';
import '../../../services/api_base_service.dart';
import '../../../services/request_method.dart';


class EventListController extends GetxController {
  var isLoading = false.obs;

  /// ✅ use typed model
  var eventList = <EventListData>[].obs;

  @override
  void onInit() {
    super.onInit();
    eventListApi();
  }

  Future<void> eventListApi() async {
    try {
      isLoading(true);

      final EventListModel response =
      await ApiBaseService.request<EventListModel>(
        '/Query/GetEventsList',
        method: RequestMethod.GET,
        authenticated: false,
      );

      /// ✅ NO re-parsing needed
      final status = response.response?.status;

      if (status == "200" || status == 200) {
  //      eventList.value = response.data ?? [];
        eventList.assignAll(response.data ?? <EventListData>[]);
      } else {
        Get.snackbar(
          "Error",
          response.response?.message ?? "Failed to load events",
        );
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading(false);
    }
  }
}