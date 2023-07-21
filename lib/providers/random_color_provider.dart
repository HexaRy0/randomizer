import 'dart:math';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'random_color_provider.g.dart';

@riverpod
class RandomColor extends _$RandomColor {
  @override
  Color build() {
    return Colors.white;
  }

  void reset() {
    state = Colors.white;
  }

  void generateRandomColor() {
    final random = Random();

    final color = Color.fromARGB(
      255,
      random.nextInt(255),
      random.nextInt(255),
      random.nextInt(255),
    );

    state = color;
  }
}
