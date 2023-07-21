import 'dart:math';

import 'package:randomizer/helper/string_extension.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:randomizer/static/word_list.dart';

part 'random_word_provider.g.dart';

@riverpod
class RandomWord extends _$RandomWord {
  @override
  List<String> build() {
    return [];
  }

  void reset() {
    state = [];
  }

  void generateRandomWord(int amount) {
    final random = Random();
    const wordList = WordList.wordLists;

    List<String> generatedWord = [];

    for (var i = 0; i < amount; i++) {
      final randomIndex = random.nextInt(wordList.length);
      final randomWord = wordList[randomIndex].capitalize();
      generatedWord.add(randomWord);
    }

    state = generatedWord;
  }
}
