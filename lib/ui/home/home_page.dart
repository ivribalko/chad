import 'package:flutter/material.dart';
import 'package:flutter_app_template/ui/common.dart';
import 'package:get/get.dart';

import 'chad_input.dart';
import 'chad_markdown.dart';
import 'lookup.dart';

class HomePage extends StatelessWidget {
  final list = Get.put(RxList<Lookup>());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Obx(
              () => ListView(
                padding: const EdgeInsets.all(kPadding),
                physics: const ClampingScrollPhysics(),
                children: list
                    .map((e) => ChadMarkdown(e))
                    .cast<Widget>()
                    .toList()
                      ..add(const Opacity(
                        opacity: 0,
                        child: TextField(maxLines: 5),
                  )),
              ),
            ),
            Column(
              children: [
                const Spacer(),
                ChadInput(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
