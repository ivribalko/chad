import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../src/model.dart';
import '../routes.dart';

class HomePage extends StatelessWidget {
  final model = Get.find<Model>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => Text('${model.count.value}')),
              IconButton(
                onPressed: () => model.count + 1,
                icon: const Icon(Icons.add),
              ),
              IconButton(
                onPressed: () => Get.toNamed(
                  Routes.page,
                  arguments: model.count.value,
                ),
                icon: const Icon(Icons.link),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
