import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'random_letter_provider.g.dart';

@riverpod
class RandomLetter extends _$RandomLetter {
  @override
  List<String> build() {
    return [];
  }

  void generateRandomLetter(int amount, String type) {
    const letters = "abcdefghijklmnopqrstuvwxyz";
    const uppercaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const bothLetters = letters + uppercaseLetters;

    final random = Random();

    List<String> generatedLetter = [];

    if (type == "uppercase") {
      for (var i = 0; i < amount; i++) {
        final randomIndex = random.nextInt(uppercaseLetters.length);
        final randomLetter = uppercaseLetters[randomIndex];
        generatedLetter.add(randomLetter);
      }
    } else if (type == "lowercase") {
      for (var i = 0; i < amount; i++) {
        final randomIndex = random.nextInt(letters.length);
        final randomLetter = letters[randomIndex];
        generatedLetter.add(randomLetter);
      }
    } else {
      for (var i = 0; i < amount; i++) {
        final randomIndex = random.nextInt(bothLetters.length);
        final randomLetter = bothLetters[randomIndex];
        generatedLetter.add(randomLetter);
      }
    }

    state = generatedLetter;
  }
}
