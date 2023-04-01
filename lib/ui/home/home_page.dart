import 'package:flutter/material.dart';
import 'package:flutter_app_template/ui/common.dart';
import 'package:get/get.dart';
import 'package:markdown_widget/config/configs.dart';
import 'package:markdown_widget/widget/all.dart';

import '../../src/model.dart';

class HomePage extends StatelessWidget {
  final chad = Get.find<Chad>();
  final back = RxList<String>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.all(kPadding),
              physics: const ClampingScrollPhysics(),
              children: [
                Obx(
                  () => MarkdownWidget(
                    data: back.join(),
                    shrinkWrap: true,
                    config: context.isDarkMode
                        ? MarkdownConfig.darkConfig
                        : MarkdownConfig.defaultConfig,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const Spacer(),
                TextField(
                  onSubmitted: (x) => chad.ask(x).listen(back.add),
                ).paddingAll(kPadding),
              ],
            )
          ],
        ),
      ),
    );
  }
}
