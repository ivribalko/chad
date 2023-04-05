import 'dart:math';

import 'package:chad/ui/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'lookup.dart';

class ChadInput extends StatelessWidget {
  static const int kMaxLines = 5;

  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  final _index = RxInt(0);
  final _focus = Get.find<RxBool>(tag: 'focus');
  final _list = Get.find<RxList<Lookup>>();

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: _setIndex,
        child: Obx(
          () {
            _focusOnRealKeyboard(context);
            return TextField(
              autofocus: true,
              focusNode: _focusNode,
              minLines: 1,
              maxLines: kMaxLines,
              controller: _controller
                ..text = _indexText() ?? ''
                ..selection = _last(),
              textInputAction: TextInputAction.done,
              onSubmitted: (i) {
                i = i.trim();
                _list.add(Lookup(i));
                _index.value = _list.length;
                _focusOnRealKeyboard(context);
              },
            ).paddingAll(kPadding);
          },
        ));
  }

  void _focusOnRealKeyboard(BuildContext context) {
    // hide cursor when app is out of focus
    _focusNode.canRequestFocus = _focus.isTrue;

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

  String? _indexText() {
    try {
      return _list[_index.value].input;
    } catch (e) {
      return null;
    }
  }
}
