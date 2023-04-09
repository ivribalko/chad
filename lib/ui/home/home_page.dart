import 'package:chad/src/chad.dart';
import 'package:chad/ui/common.dart';
import 'package:chad/ui/watcher/watcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'chad_input.dart';
import 'chad_markdown.dart';
import 'google_button.dart';

class HomePage extends StatelessWidget {
  final list = Get.find<Chad>().list;

  HomePage() {
    if (!Get.isRegistered<ItemScrollController>()) {
      final scroll = Get.put(ItemScrollController());
      list.listen((_) {
        scroll.scrollTo(
          index: list.length - 1,
          duration: kDuration,
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Obx(
              () => ScrollablePositionedList.builder(
                padding: EdgeInsets.all(kPadding),
                physics: const ClampingScrollPhysics(),
                itemScrollController: Get.find<ItemScrollController>(),
                itemCount: list.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  return index == list.length
                      ? Opacity(
                          opacity: 0,
                          child: Container(
                              height: context.height -
                                  context.mediaQueryPadding.top -
                                  context.mediaQueryPadding.bottom -
                                  kPadding),
                        )
                      : Column(children: [
                          Stack(children: [
                            ChadMarkdown(list[index]),
                            Positioned(
                                top: -5,
                                right: -10,
                                child: GoogleButton(list[index].query))
                          ]),
                          const Divider(),
                        ]);
                },
              ),
            ).apply(
              (v) => ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: v,
              ),
            ),
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
