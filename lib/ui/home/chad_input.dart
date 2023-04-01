import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common.dart';

class ChadInput extends StatelessWidget {
  final void Function(dynamic x)? onSubmitted;
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  ChadInput(this.onSubmitted);

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      focusNode: _focusNode,
      minLines: 1,
      maxLines: 5,
      controller: _controller,
      textInputAction: TextInputAction.done,
      onSubmitted: (x) {
        onSubmitted?.call(x);
        _controller.clear();
        _focusNode.requestFocus();
      },
    ).paddingAll(kPadding);
  }
}
