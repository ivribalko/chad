import 'package:flutter/material.dart';

const Duration kDuration = Duration(milliseconds: 400);
const double kPadding = 20.0;
const double kBetween = 10.0;
const double kSize = 17.0;

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
  Widget apply(Function(Widget) function) {
    return function(this);
  }

  Widget unfocusable() {
    return Focus(
      descendantsAreFocusable: false,
      canRequestFocus: false,
      child: this,
    );
  }

  Widget noScrollBar(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: this,
    );
  }
}
