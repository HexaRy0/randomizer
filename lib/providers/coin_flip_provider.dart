import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'coin_flip_provider.g.dart';

@riverpod
class CoinFlip extends _$CoinFlip {
  @override
  String build() {
    return "";
  }

  void reset() {
    state = "";
  }

  void flipCoin() {
    String output = "";

    output += ["heads", "tails"][Random().nextInt(2)];

    state = output;
  }
}
