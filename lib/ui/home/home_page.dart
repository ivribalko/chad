import 'package:flutter/material.dart';
import 'package:flutter_app_template/ui/common.dart';
import 'package:get/get.dart';

import 'chad_input.dart';
import 'chad_markdown.dart';
import 'google_button.dart';
import 'lookup.dart';

class HomePage extends StatelessWidget {
  final list = Get.put(RxList<Lookup>());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Focus(
              descendantsAreFocusable: false,
              canRequestFocus: false,
              child: Obx(
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
                                  child: GoogleButton(e.input))
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
              ),
            ),
            Column(children: [
              const Spacer(),
              ChadInput(),
            ])
          ],
        ),
      ),
    );
  }
}
