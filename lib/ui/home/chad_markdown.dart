import 'package:chad/src/lookup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markdown_widget/config/configs.dart';
import 'package:markdown_widget/widget/all.dart';

class ChadMarkdown extends StatelessWidget {
  final Lookup lookup;

  late final String title = lookup.query.replaceAll(RegExp('^'), '>');

  ChadMarkdown(this.lookup);

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
