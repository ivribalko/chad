import 'package:chad/ui/home/chad_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EditButton extends StatelessWidget {
  final int index;

  const EditButton(this.index);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      splashRadius: 0.01,
      color: context.theme.hintColor.withAlpha(80),
      onPressed: () => Get.find<ChadInputState>()
        ..index.value = index
        ..focusInput(),
      icon: const Icon(MdiIcons.noteEdit),
    );
  }
}
