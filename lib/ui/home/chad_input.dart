import 'dart:io';

import 'package:chad/src/chad.dart';
import 'package:chad/ui/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChadInput extends StatefulWidget {
  @override
  State<ChadInput> createState() => _ChadInputState();
}

class _ChadInputState extends State<ChadInput> {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  final chad = Get.find<Chad>();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      focusNode: focusNode,
      controller: controller,
      onSubmitted: (value) {
        value = value.trim();
        controller.clear();
        if (value.isNotEmpty) {
          chad.ask(value);
        }
        if (isNotMobile) {
          focusNode.requestFocus();
        }
      },
    ).paddingAll(kPadding);
  }

  bool get isNotMobile => kIsWeb || (!Platform.isAndroid && !Platform.isIOS);
}
