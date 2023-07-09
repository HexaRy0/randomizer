import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'random_number_provider.g.dart';

@riverpod
class RandomNumber extends _$RandomNumber {
  @override
  String build() {
    return "";
  }

  void generateRandomNumber(int amount, int min, int max, bool unique) {
    String output = "";

    if (unique) {
      if (amount > (max - min + 1)) {
        output = "Amount must be less than or equal to the range";
      } else {
        List<int> numbers = [];
        for (int i = min; i <= max; i++) {
          numbers.add(i);
        }
        numbers.shuffle();
        for (int i = 0; i < amount; i++) {
          output += "${numbers[i]}, ";
        }
      }
    } else {
      for (int i = 0; i < amount; i++) {
        output += "${Random().nextInt(max - min + 1) + min}, ";
      }
    }

    output = output.substring(0, output.length - 2);

    state = output;
  }
}
