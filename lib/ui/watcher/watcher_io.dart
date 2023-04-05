import 'package:flutter/material.dart';

void watch(instance) {
  WidgetsBinding.instance.addObserver(instance);
}

void unwatch(instance) {
  WidgetsBinding.instance.removeObserver(instance);
}
