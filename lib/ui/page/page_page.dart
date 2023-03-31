import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../src/common.dart';

class PagePage extends StatelessWidget {
  final save = GetStorage(kSave);
  final int args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('$args'),
        ),
        body: Center(
          child: Switch(
            value: Get.isDarkMode,
            onChanged: (x) => save.write(
              kDarkMode,
              !Get.isDarkMode,
            ),
          ),
        ),
      ),
    );
  }
}
