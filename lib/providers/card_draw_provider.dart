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
    List<String> cardNumbers;
    List<String> cards = [];

    if (deckType == "standard") {
      cardNumbers = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"];
    } else {
      cardNumbers = [
        "Ace",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "10",
        "Jack",
        "Queen",
        "King",
        "Joker",
        "Joker"
      ];
    }

    for (String cardClass in cardClasses) {
      for (String cardNumber in cardNumbers) {
        if (cardNumber == "Joker") {
          cards.add(cardNumber);
          continue;
        }
        cards.add("$cardNumber of $cardClass");
      }
    }

    if (unique) {
      if (amount > 52) {
        output.add("Amount must be less than or equal to the range");
      } else {
        cards.shuffle();
        for (int i = 0; i < amount; i++) {
          output.add(cards[i]);
        }
      }
    } else {
      for (int i = 0; i < amount; i++) {
        output.add(cards[Random().nextInt(52)]);
      }
    }

    state = output;
  }
}
