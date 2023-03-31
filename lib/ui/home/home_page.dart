import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../src/model.dart';

class HomePage extends StatelessWidget {
  final chad = Get.find<Chad>();
  final back = RxList<String>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextField(onSubmitted: (x) => chad.ask(x).listen(back.add)),
            Obx(() => Text(back.join())),
          ],
        ),
      ),
    );
  }
}
