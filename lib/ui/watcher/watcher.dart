import 'watcher_stub.dart'
    if (dart.library.io) 'watcher_io.dart'
    if (dart.library.html) 'watcher_web.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Sends app lifecycle events.
class Watcher extends StatefulWidget {
  @override
  State<Watcher> createState() => _WatcherState();
}

class _WatcherState extends State<Watcher> with WidgetsBindingObserver {
  final focus = Get.find<RxBool>(tag: 'focus');

  void onFocus(e) {
    didChangeAppLifecycleState(AppLifecycleState.resumed);
  }

  void onBlur(e) {
    didChangeAppLifecycleState(AppLifecycleState.paused);
  }

  @override
  void initState() {
    super.initState();
    watch(this);
  }

  @override
  void dispose() {
    unwatch(this);
    super.dispose();
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
