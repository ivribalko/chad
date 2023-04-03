import 'package:flutter/material.dart';
import 'package:flutter_app_template/src/common.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'home/home_page.dart';
import 'routes.dart';

class App extends StatelessWidget {
  final save = GetStorage(kSave);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Chad',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: Get.isPlatformDarkMode ? ThemeMode.dark : ThemeMode.light,
      getPages: [
        GetPage(name: Routes.home, page: () => HomePage()),
      ],
    );
  }
}
