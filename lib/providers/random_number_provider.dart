import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'random_number_provider.g.dart';

@riverpod
class RandomNumber extends _$RandomNumber {
  @override
  List<int> build() {
    return [];
  }

  void reset() {
    state = [];
  }

  void generateRandomNumber(int amount, int min, int max, bool unique) {
    List<int> output = [];

    if (unique) {
      List<int> numbers = [];
      for (int i = min; i <= max; i++) {
        numbers.add(i);
      }
      numbers.shuffle();
      for (int i = 0; i < amount; i++) {
        output.add(numbers[i]);
      }
    } else {
      for (int i = 0; i < amount; i++) {
        output.add(Random().nextInt(max - min + 1) + min);
      }
    }

    state = output;
  }
}
