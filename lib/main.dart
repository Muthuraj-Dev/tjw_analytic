
import 'dart:convert';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tjw_analytics_new/router.dart';
import 'package:tjw_analytics_new/services/network_service.dart';
import 'package:tjw_analytics_new/ui/controller/eventController.dart';
import 'package:toastification/toastification.dart';


import 'core/res/colors.dart';
import 'core/res/styles.dart';

import 'locator.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   setupLocator();
//
//   locator<NetworkService>().onInit();
//
//   runApp(
//     DevicePreview(
//       enabled: !kReleaseMode,
//       builder: (context) => MyApp(),
//     ),
//   );
// }


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  setupLocator();
  locator<NetworkService>().onInit();

  Get.put(EventController());

  /// ✅ restore saved event
  await Get.find<EventController>().loadEvent();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: AppColor.black,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  // runApp(MyApp());

  runApp(
    const ToastificationWrapper(
      child: MyApp(),
    ),
  );
  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) => MyApp(),
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return GetMaterialApp(
      title: 'Retailer',
      initialRoute: '/',  // login
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.pages,
      theme: AppStyle.appTheme,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
    );
  }
}
