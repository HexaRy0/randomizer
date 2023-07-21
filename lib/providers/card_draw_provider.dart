import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'card_draw_provider.g.dart';

@riverpod
class CardDraw extends _$CardDraw {
  @override
  List<String> build() {
    return [];
  }

  void drawCard(String deckType, int amount, bool unique) {
    List<String> output = [];

    List<String> cardClasses = ["Hearts", "Diamonds", "Clubs", "Spades"];
    List<String> cardNumbers = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"];
    List<String> cards = [];

    for (String cardClass in cardClasses) {
      for (String cardNumber in cardNumbers) {
        cards.add("$cardNumber of $cardClass");
      }
    }

    if (deckType == "standard-joker") {
      cards.add("Joker");
      cards.add("Joker");
    }

    if (unique) {
      cards.shuffle();
      for (int i = 0; i < amount; i++) {
        output.add(cards[i]);
      }
    } else {
      for (int i = 0; i < amount; i++) {
        output.add(cards[Random().nextInt(cards.length)]);
      }
    }

    state = output;
  }
}
