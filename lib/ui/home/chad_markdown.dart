import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markdown_widget/config/configs.dart';
import 'package:markdown_widget/widget/all.dart';

import 'lookup.dart';

class ChadMarkdown extends StatelessWidget {
  final Lookup lookup;

  ChadMarkdown(this.lookup);

  late String title = lookup.input.replaceAll(RegExp('^'), '>');

  @override
  Widget build(BuildContext context) {
    return Obx(() => MarkdownWidget(
          data: "$title\n\n${lookup.reply.join()}",
          shrinkWrap: true,
          config: context.isDarkMode
              ? MarkdownConfig.darkConfig
              : MarkdownConfig.defaultConfig,
        ));
  }
}
