import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const Duration kDuration = Duration(milliseconds: 400);

double get kPadding => isMobile ? 10.0 : 20.0;

bool get isMobile => !isNotMobile;

bool get isNotMobile => kIsWeb || (!Platform.isAndroid && !Platform.isIOS);

class CommonFutureBuilder<T> extends StatelessWidget {
  const CommonFutureBuilder({
    Key? key,
    required this.future,
    required this.result,
  }) : super(key: key);

  /// Target future to wait for.
  final Future<T> future;

  /// Widget to use upon future completion with its result value.
  final Widget Function(T? value) result;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (_, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('${snapshot.error}'));
        } else if (snapshot.connectionState == ConnectionState.done) {
          return result(snapshot.data);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

extension WidgetExtensions on Widget {
  Widget apply(Widget Function(Widget) function) {
    return function(this);
  }
}
