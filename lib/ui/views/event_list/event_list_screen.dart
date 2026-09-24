import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tjw_analytics_new/ui/controller/eventController.dart';

import '../../../core/res/colors.dart';

// import your dashboard screen
import '../../../services/secure_storage_service.dart';
import '../dashboard/dashboard_screen.dart';
import 'event_list_controller.dart';

// class EventListScreen extends StatelessWidget {
//   const EventListScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final events = List.generate(
//       7,
//       (index) => {
//         "title": "GJIIF",
//         "edition": "${12 - index}th Edition",
//         "date": "Mar 6,7,8 2026",
//       },
//     );
//
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 60),
//
//             const Text(
//               "Select the Event",
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
//             ),
//
//             /// ✅ LIST OF EVENTS
//             Expanded(
//               child: ListView.separated(
//                 itemCount: events.length,
//                 separatorBuilder: (_, __) => const SizedBox(height: 10),
//                 itemBuilder: (context, index) {
//                   final event = events[index];
//
//                   return InkWell(
//                     borderRadius: BorderRadius.circular(20),
//                     onTap: () {
//                       print("Clicked: ${event["edition"]}");
//
//                       /// ✅ NAVIGATION
//                       Get.offAll(() => DashboardScreen());
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         color: AppColor.white,
//                         border: Border.all(color: AppColor.green),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Row(
//                         children: [
//                           /// SVG BOX
//                           Container(
//                             width: 88,
//                             height: 65,
//                             decoration: BoxDecoration(
//                               color: AppColor.green,
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Center(
//                               child: SvgPicture.asset(
//                                 'assets/GJIIF.svg',
//                               ),
//                             ),
//                           ),
//
//                           const SizedBox(width: 12),
//
//                           /// TEXT
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 event["title"]!,
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               Text(
//                                 event["edition"]!,
//                                 style: const TextStyle(fontSize: 16),
//                               ),
//                               Text(
//                                 event["date"]!,
//                                 style: const TextStyle(fontSize: 16),
//                               ),
//                             ],
//                           ),
//
//                           const Spacer(),
//
//                           const Icon(Icons.arrow_forward_ios, size: 18),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class EventListScreen extends StatelessWidget {
  const EventListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EventListController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),

            const Text(
              "Select the Event",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),

            /// ✅ REACTIVE UI
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.eventList.isEmpty) {
                  return const Center(child: Text("No events found"));
                }

                return ListView.separated(
                  itemCount: controller.eventList.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final event = controller.eventList[index];

                    return InkWell(
                      borderRadius: BorderRadius.circular(20),
                      // onTap: () async {
                      //   print("Clicked: ${event.eventName}");
                      //   print("Clicked ID: ${event.eventID}");
                      //
                      //   final storage = SecureStorageService();
                      //
                      //   /// ✅ remove only this key
                      //   await storage.delete("eventId");
                      //
                      //   /// ✅ write new value
                      //   await storage.write(
                      //     "eventId",
                      //     event.eventID.toString(),
                      //   );
                      //
                      //   Get.offAll(() => DashboardScreen());
                      // },

                      onTap: () async {
                        final appController = Get.find<EventController>();

                        print("Clicked: ${event.eventName}");
                        print("Clicked ID: ${event.eventID}");

                        /// ✅ update global state
                        await appController.setEvent(event);

                        Get.offAll(() => DashboardScreen());
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          border: Border.all(color: AppColor.green),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            /// SVG BOX


                            Container(
                              width: 88,
                              height: 65,
                              decoration: BoxDecoration(
                                color: AppColor.green,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  event.eventLogoURL ?? "",
                                  fit: BoxFit.contain,
                                  errorBuilder: (_, __, ___) => const Icon(Icons.image),
                                  loadingBuilder: (context, child, progress) {
                                    if (progress == null) return child;
                                    return const Center(
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(strokeWidth: 2),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),

                            /// TEXT
                            Expanded (
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    event.eventName ?? "No Name",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    event.eventDate ?? "",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    event.eventCity ?? "",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),

                      //      const Spacer(),

                            const Icon(Icons.arrow_forward_ios, size: 18),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
