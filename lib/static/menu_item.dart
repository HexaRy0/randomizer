import 'package:randomizer/model/menu_item.dart';
import 'package:randomizer/static/route_name.dart';
import 'package:randomizer/static/strings.dart';

final List<MenuItem> menuItem = [
  MenuItem(
    title: StaticStrings.randomNumber,
    route: RouteName.randomNumber,
  ),
  MenuItem(
    title: StaticStrings.coinFlip,
    route: RouteName.coinFlip,
  ),
  MenuItem(
    title: StaticStrings.diceRoll,
    route: RouteName.diceRoll,
  ),
  MenuItem(
    title: StaticStrings.cardDraw,
    route: RouteName.cardDraw,
  ),
  MenuItem(
    title: StaticStrings.groupBuilder,
    route: RouteName.groupBuilder,
  ),
  MenuItem(
    title: StaticStrings.listRandomizer,
    route: RouteName.listRandomizer,
  ),
  MenuItem(
    title: StaticStrings.passwordGenerator,
    route: RouteName.passwordGenerator,
  ),
  MenuItem(
    title: StaticStrings.randomColor,
    route: RouteName.randomColor,
  ),
  MenuItem(
    title: StaticStrings.randomLetter,
    route: RouteName.randomLetter,
  ),
  MenuItem(
    title: StaticStrings.randomWord,
    route: RouteName.randomWord,
  ),
  MenuItem(
    title: StaticStrings.randomDate,
    route: RouteName.randomDate,
  ),
  MenuItem(
    title: StaticStrings.randomTime,
    route: RouteName.randomTime,
  ),
  MenuItem(
    title: StaticStrings.randomAnimal,
    route: RouteName.randomAnimal,
  ),
];
