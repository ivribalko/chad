import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../src/common.dart';

const Duration kDuration = Duration(milliseconds: 400);
const double kPadding = 20.0;
const double kBetween = 10.0;

ThemeMode getThemeMode(GetStorage save) {
  if (save.hasData(kDarkMode)) {
    return save.read(kDarkMode) ? ThemeMode.dark : ThemeMode.light;
  } else {
    return Get.isPlatformDarkMode ? ThemeMode.dark : ThemeMode.light;
  }
}

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

extension TextStyleExtension on TextStyle {
  TextStyle by(double fontSize, int fontWeight) {
    return copyWith(
      fontSize: fontSize,
      fontWeight: FontWeight.values[(fontWeight / 100).round() - 1],
    );
  }
}

extension Padded on Widget {
  Widget paddedX(double x) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: x),
      child: this,
    );
  }

  Widget paddedY(double y) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: y),
      child: this,
    );
  }

  Widget paddedXY(double x, double y) {
    return Padding(
      padding: EdgeInsets.fromLTRB(x, y, x, y),
      child: this,
    );
  }
}

extension WidgetListExtension on List<Widget> {
  List<Widget> paddingBetween({double by = kBetween}) {
    return List.generate(
      length * 2 - 1,
      (index) => index % 2 == 1
          ? SizedBox(
              height: by,
              width: by,
            )
          : this[(index / 2).round()],
    );
  }
}
