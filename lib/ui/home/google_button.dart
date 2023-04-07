import 'package:chad/ui/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class GoogleButton extends StatelessWidget {
  final String input;

  GoogleButton(this.input);

  late String url = Uri.encodeFull('https://www.google.com/search?q=$input');

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: kSize,
      color: context.theme.hintColor,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: () => launchUrlString(url),
      icon: const Icon(MdiIcons.google),
    );
  }
}
