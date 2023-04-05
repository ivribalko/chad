import 'package:chad/src/lookup.dart';
import 'package:chad/ui/common.dart';
import 'package:chad/ui/watcher/watcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chad_input.dart';
import 'chad_markdown.dart';
import 'google_button.dart';

class HomePage extends StatelessWidget {
  final list = Get.find<RxList<Lookup>>();

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
                    .map((e) => Column(children: [
                          Stack(children: [
                            ChadMarkdown(e),
                            Positioned(
                                top: -5,
                                right: -10,
                                child: GoogleButton(e.query))
                          ]),
                          const Divider(),
                        ]))
                    .cast<Widget>()
                    .toList()
                  ..add(const Opacity(
                    opacity: 0,
                    child: TextField(maxLines: ChadInput.kMaxLines),
                  )),
              ),
            ).unfocusable().noScrollBar(context),
            Column(children: [
              const Spacer(),
              ChadInput(),
              Watcher(),
            ])
          ],
        ),
      ),
    );
  }
}
