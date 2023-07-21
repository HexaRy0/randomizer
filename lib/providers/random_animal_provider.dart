import 'dart:math';

import 'package:randomizer/static/animal_list.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'random_animal_provider.g.dart';

@riverpod
class RandomAnimal extends _$RandomAnimal {
  @override
  List<String> build() {
    return [];
  }

  void reset() {
    state = [];
  }

  void generateRandomAnimal(int amount) {
    final random = Random();
    const animalLists = AnimalList.animalLists;

    List<String> generatedAnimal = [];

    for (var i = 0; i < amount; i++) {
      final randomIndex = random.nextInt(animalLists.length);
      final randomAnimal = animalLists[randomIndex];
      generatedAnimal.add(randomAnimal);
    }

    state = generatedAnimal;
  }
}
