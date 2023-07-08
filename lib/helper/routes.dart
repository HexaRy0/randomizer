import 'package:flutter/material.dart';
import 'package:randomizer/screens/about/about.dart';
import 'package:randomizer/screens/home/home.dart';
import 'package:randomizer/screens/randomizer/card_draw/card_draw.dart';
import 'package:randomizer/screens/randomizer/coin_flip/coin_flip.dart';
import 'package:randomizer/screens/randomizer/dice_roll/dice_roll.dart';
import 'package:randomizer/screens/randomizer/list_randomizer/list_randomizer.dart';
import 'package:randomizer/screens/randomizer/password_generator/password_generator.dart';
import 'package:randomizer/screens/randomizer/random_animal/random_animal.dart';
import 'package:randomizer/screens/randomizer/random_color/random_color.dart';
import 'package:randomizer/screens/randomizer/random_date/random_date.dart';
import 'package:randomizer/screens/randomizer/random_letter/random_letter.dart';
import 'package:randomizer/screens/randomizer/random_number/random_number.dart';
import 'package:randomizer/screens/randomizer/random_time/random_time.dart';
import 'package:randomizer/screens/randomizer/random_word/random_word.dart';
import 'package:randomizer/screens/randomizer/randomizer.dart';
import 'package:randomizer/screens/settings/settings.dart';
import 'package:randomizer/static/route_name.dart';
import 'package:randomizer/static/strings.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  RouteName.home: (context) => const HomeScreen(),
  RouteName.about: (context) => const AboutScreen(),
  RouteName.settings: (context) => const SettingsScreen(),
  RouteName.randomNumber: (context) => const RandomizerScreen(
        title: StaticStrings.randomNumber,
        body: RandomNumber(),
      ),
  RouteName.coinFlip: (context) => const RandomizerScreen(
        title: StaticStrings.coinFlip,
        body: CoinFlip(),
      ),
  RouteName.diceRoll: (context) => const RandomizerScreen(
        title: StaticStrings.diceRoll,
        body: DiceRoll(),
      ),
  RouteName.cardDraw: (context) => const RandomizerScreen(
        title: StaticStrings.cardDraw,
        body: CardDraw(),
      ),
  RouteName.listRandomizer: (context) => const RandomizerScreen(
        title: StaticStrings.listRandomizer,
        body: ListRandomizer(),
      ),
  RouteName.passwordGenerator: (context) => const RandomizerScreen(
        title: StaticStrings.passwordGenerator,
        body: PasswordGenerator(),
      ),
  RouteName.randomColor: (context) => const RandomizerScreen(
        title: StaticStrings.randomColor,
        body: RandomColor(),
      ),
  RouteName.randomLetter: (context) => const RandomizerScreen(
        title: StaticStrings.randomLetter,
        body: RandomLetter(),
      ),
  RouteName.randomWord: (context) => const RandomizerScreen(
        title: StaticStrings.randomWord,
        body: RandomWord(),
      ),
  RouteName.randomDate: (context) => const RandomizerScreen(
        title: StaticStrings.randomDate,
        body: RandomDate(),
      ),
  RouteName.randomTime: (context) => const RandomizerScreen(
        title: StaticStrings.randomTime,
        body: RandomTime(),
      ),
  RouteName.randomAnimal: (context) => const RandomizerScreen(
        title: StaticStrings.randomAnimal,
        body: RandomAnimal(),
      ),
};
