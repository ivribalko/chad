import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Sends app lifecycle events.
class Watcher extends StatefulWidget {
  @override
  State<Watcher> createState() => _WatcherState();
}

class _WatcherState extends State<Watcher> with WidgetsBindingObserver {
  final focus = Get.find<RxBool>(tag: 'focus');

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      window.addEventListener('focus', onFocus);
      window.addEventListener('blur', onBlur);
    } else {
      WidgetsBinding.instance.addObserver(this);
    }
  }

  @override
  void dispose() {
    if (kIsWeb) {
      window.removeEventListener('focus', onFocus);
      window.removeEventListener('blur', onBlur);
    } else {
      WidgetsBinding.instance.removeObserver(this);
    }
    super.dispose();
  }

  void onFocus(Event e) {
    didChangeAppLifecycleState(AppLifecycleState.resumed);
  }

  void onBlur(Event e) {
    didChangeAppLifecycleState(AppLifecycleState.paused);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        focus.value = true;
        break;
      default:
        focus.value = false;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: false,
      child: Container(),
    );
  }
}
