import 'dart:io';
import 'dart:math';

import 'package:chad/src/chad.dart';
import 'package:chad/ui/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ChadInput extends StatefulWidget {
  @override
  State<ChadInput> createState() => _ChadInputState();
}

class _ChadInputState extends State<ChadInput> {
  final appFocus = Get.find<RxBool>(tag: 'focus');
  final controller = TextEditingController();
  final inputNode = FocusNode();
  final keyboardNode = FocusNode()..canRequestFocus = false;
  final index = RxInt(0);
  final chad = Get.find<Chad>();

  String current = "";
  TextSelection? selection;

  @override
  void initState() {
    super.initState();
    index.stream.takeWhile((v) => mounted).listen((event) {
      setState(() {
        controller.text = getText();
        // setting controller.selection doesn't seem to be enough here
        // still need to set it on the controller inside build function
        controller.selection = selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length),
        );
      });
    });
    appFocus.stream.takeWhile((v) => mounted).listen((event) {
      setState(() async {
        if (event) {
          inputNode.canRequestFocus = true;
          if (isMobile) {
            // android doesn't open keyboard unless there's a delay
            await Future.delayed(50.milliseconds);
          }
          inputNode.requestFocus();
          controller.selection = selection ?? controller.selection;
        } else {
          selection = controller.selection;
          inputNode.canRequestFocus = false;
        }
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    inputNode.dispose();
    keyboardNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      onKey: setIndex,
      focusNode: keyboardNode,
      child: TextField(
        autofocus: true,
        focusNode: inputNode,
        controller: controller
          ..text = getText()
          ..selection = selection ?? controller.selection,
        onChanged: (v) {
          selection = null;
          if (editingNew) {
            current = v;
          }
        },
        onSubmitted: (v) {
          current = "";
          selection = null;
          controller.clear();
          if (isNotMobile) {
            inputNode.requestFocus();
          }
          v = v.trim();
          if (v.isNotEmpty) {
            chad.ask(v);
            index.value = chad.list.length;
          }
        },
      ).paddingAll(kPadding),
    );
  }

  bool get isMobile => !isNotMobile;

  bool get isNotMobile => kIsWeb || (!Platform.isAndroid && !Platform.isIOS);

  String getText() {
    if (editingNew) {
      return current;
    } else {
      return chad.list[index.value].query;
    }
  }

  bool get editingNew => index.value == chad.list.length;

  void setIndex(v) {
    if (v.runtimeType == RawKeyDownEvent) {
      if (controller.text.isEmpty ||
          controller.text.length == controller.selection.baseOffset) {
        if (v.logicalKey == LogicalKeyboardKey.arrowUp) {
          index.value = max(index.value - 1, 0);
        }
        if (v.logicalKey == LogicalKeyboardKey.arrowDown) {
          index.value = min(index.value + 1, chad.list.length);
        }
      }
    }
  }
}
