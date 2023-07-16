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

  void generateRandomTime(int amount, DateTime startTime, DateTime endTime) {
    final random = Random();

    List<String> generatedTime = [];

    final isSameHour = startTime.hour == endTime.hour;
    final isSameMinute = startTime.minute == endTime.minute;

    for (var i = 0; i < amount; i++) {
      final randomTime = TimeOfDay(
        hour: !isSameHour
            ? startTime.hour + random.nextInt(endTime.hour - startTime.hour)
            : startTime.hour,
        minute: !isSameMinute
            ? startTime.minute + random.nextInt(endTime.minute - startTime.minute)
            : startTime.minute,
      );

      generatedTime.add("${randomTime.hour}:${randomTime.minute}");
    }

    state = generatedTime;
  }
}
