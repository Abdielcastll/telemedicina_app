import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicina_app/core/routes/app_pages.dart';

class TelemedicinaApp extends StatelessWidget {
  const TelemedicinaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.initial,
      getPages: AppPages.pages,
    );
  }
}
