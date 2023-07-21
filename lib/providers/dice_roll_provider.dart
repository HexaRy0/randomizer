import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dice_roll_provider.g.dart';

@riverpod
class DiceRoll extends _$DiceRoll {
  @override
  List<int> build() {
    return [];
  }

  void reset() {
    state = [];
  }

  void rollDice(int sides, int amount) {
    List<int> output = [];
    List<int> numbers = [];

    for (int i = 1; i <= sides; i++) {
      numbers.add(i);
    }

    for (int i = 0; i < amount; i++) {
      output.add(Random().nextInt(sides) + 1);
    }

    state = output;
  }
}
