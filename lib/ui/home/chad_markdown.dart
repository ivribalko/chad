import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markdown_widget/config/configs.dart';
import 'package:markdown_widget/widget/all.dart';

import 'lookup.dart';

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
