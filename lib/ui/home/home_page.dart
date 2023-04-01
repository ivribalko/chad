import 'package:flutter/material.dart';
import 'package:flutter_app_template/ui/common.dart';
import 'package:get/get.dart';
import 'package:markdown_widget/config/configs.dart';
import 'package:markdown_widget/widget/all.dart';

import '../../src/model.dart';

class HomePage extends StatelessWidget {
  final list = RxList<Lookup>();

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
                children: list.map((e) => ChadMarkdown(e)).toList(),
              ),
            ),
            Column(
              children: [
                const Spacer(),
                TextField(
                  onSubmitted: (x) => list.add(Lookup(x)),
                ).paddingAll(kPadding),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ChadMarkdown extends StatelessWidget {
  final Lookup lookup;

  const ChadMarkdown(this.lookup);

  @override
  Widget build(BuildContext context) {
    return Obx(() => MarkdownWidget(
          data: "### ${lookup.input}\n\n${lookup.reply.join()}",
          shrinkWrap: true,
          config: context.isDarkMode
              ? MarkdownConfig.darkConfig
              : MarkdownConfig.defaultConfig,
        ));
  }
}

class Lookup {
  final String input;
  final reply = RxList<String>();

  Lookup(this.input) {
    Get.find<Chad>().ask(input).listen(reply.add);
  }
}
