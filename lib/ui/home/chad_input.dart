import 'dart:math';

import 'package:chad/src/chad.dart';
import 'package:chad/src/lookup.dart';
import 'package:chad/ui/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ChadInput extends StatelessWidget {
  final _current = Get.isRegistered<RxString>()
      ? Get.find<RxString>()
      : Get.put(RxString(""));

  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  final _scroll = Get.find<ScrollController>();
  final _index = RxInt(0);
  final _focus = Get.find<RxBool>(tag: 'focus');
  final _list = Get.find<RxList<Lookup>>();
  final _chad = Get.find<Chad>();

  @override
  Widget build(BuildContext context) {
    _controller.addListener(() {
      if (_index.value == _list.length) {
        _current.value = _controller.text;
      }
    });
    return RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: _setIndex,
        child: Obx(
          () {
            // hide cursor when app is out of focus
            _focusNode.canRequestFocus = _focus.isTrue;
            return Container(
              decoration: BoxDecoration(
                color: context.theme.dialogBackgroundColor,
              ),
              child: TextField(
                autofocus: true,
                focusNode: _focusNode,
                minLines: 1,
                maxLines: 5,
                controller: _controller
                  ..text = _indexText() ?? ''
                  ..selection = _last(),
                textInputAction: TextInputAction.done,
                onSubmitted: (i) {
                  _focusIfRealKeyboard(context);
                  i = i.trim();
                  if (i.isNotEmpty) {
                    _chad.ask(i);
                    _current.value = "";
                    _index.value = _list.length;
                    _scroll.jumpTo(_scroll.position.maxScrollExtent);
                  }
                },
              ).paddingOnly(
                left: kPadding,
                right: kPadding,
                bottom: kPadding,
              ),
            );
          },
        ));
  }

  void _focusIfRealKeyboard(BuildContext context) {
    // one strange way but is there better
    // probably not because web is busted
    context
        .responsiveValue(
          desktop: _focusNode.requestFocus,
          mobile: () {},
        )
        .call();
  }

  void _setIndex(i) {
    if (i.runtimeType == RawKeyDownEvent) {
      if (_controller.selection.baseOffset == _controller.text.length) {
        if (i.logicalKey == LogicalKeyboardKey.arrowUp) {
          _index.value = max(_index.value - 1, 0);
        }
        if (i.logicalKey == LogicalKeyboardKey.arrowDown) {
          _index.value = min(_index.value + 1, _list.length);
        }
      }
    }
  }

  TextSelection _last() {
    return TextSelection.fromPosition(
      TextPosition(offset: _controller.text.length),
    );
  }

  String _indexText() {
    try {
      return _list[_index.value].query;
    } catch (e) {
      return _current.value;
    }
  }
}
