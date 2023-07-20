import 'dart:math';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'random_time_provider.g.dart';

@riverpod
class RandomTime extends _$RandomTime {
  @override
  List<String> build() {
    return [];
  }

  void generateRandomTime(int amount, DateTime startTime, DateTime endTime, bool unique) {
    final random = Random();

    List<String> generatedTime = [];

    for (var i = 0; i < amount; i++) {
      debugPrint(startTime.toString());
      debugPrint(endTime.toString());
      debugPrint(endTime.difference(startTime).inMinutes.toString());
      final randomTime = startTime.add(
        Duration(
          minutes: random.nextInt(endTime.difference(startTime).inMinutes + 2),
        ),
      );

      final hour = randomTime.hour.toString().padLeft(2, '0');
      final minute = randomTime.minute.toString().padLeft(2, '0');

      if (unique) {
        if (!generatedTime.contains("$hour:$minute")) {
          generatedTime.add("$hour:$minute");
        } else {
          i--;
        }
      } else {
        generatedTime.add("$hour:$minute");
      }
    }

    state = generatedTime;
  }
}
