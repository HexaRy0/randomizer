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
import 'package:randomizer/screens/settings/settings.dart';
import 'package:randomizer/static/route_name.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  RouteName.home: (context) => const HomeScreen(),
  RouteName.about: (context) => const AboutScreen(),
  RouteName.settings: (context) => const SettingsScreen(),
  RouteName.randomNumber: (context) => const RandomNumberScreen(),
  RouteName.coinFlip: (context) => const CoinFlipScreen(),
  RouteName.diceRoll: (context) => const DiceRollScreen(),
  RouteName.cardDraw: (context) => const CardDrawScreen(),
  RouteName.listRandomizer: (context) => const ListRandomizerScreen(),
  RouteName.passwordGenerator: (context) => const PasswordGeneratorScreen(),
  RouteName.randomColor: (context) => const RandomColorScreen(),
  RouteName.randomLetter: (context) => const RandomLetterScreen(),
  RouteName.randomWord: (context) => const RandomWordScreen(),
  RouteName.randomDate: (context) => const RandomDateScreen(),
  RouteName.randomTime: (context) => const RandomTimeScreen(),
  RouteName.randomAnimal: (context) => const RandomAnimalScreen(),
};
