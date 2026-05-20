import 'dart:convert';
import 'package:get/get.dart';
import '../../../services/secure_storage_service.dart';
import '../../core/model/event_list_model.dart';


class EventController extends GetxController {
  final storage = SecureStorageService();

  var selectedEvent = Rxn<EventListData>();

  Future<void> setEvent(EventListData event) async {
    selectedEvent.value = event;

    await storage.write(
      "eventData",
      jsonEncode(event.toJson()),
    );
  }

  Future<void> loadEvent() async {
    final stored = await storage.read("eventData");

    if (stored != null) {
      selectedEvent.value =
          EventListData.fromJson(jsonDecode(stored));
    }
  }
}