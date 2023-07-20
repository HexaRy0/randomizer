import 'package:randomizer/helper/icon_type.dart';
import 'package:randomizer/model/menu_item.dart';
import 'package:randomizer/static/route_name.dart';
import 'package:randomizer/static/strings.dart';

final List<MenuItem> menuItem = [
  MenuItem(
    iconType: IconType.number,
    title: StaticStrings.randomNumber,
    route: RouteName.randomNumber,
  ),
  MenuItem(
    iconType: IconType.coin,
    title: StaticStrings.coinFlip,
    route: RouteName.coinFlip,
  ),
  MenuItem(
    iconType: IconType.dice,
    title: StaticStrings.diceRoll,
    route: RouteName.diceRoll,
  ),
  MenuItem(
    iconType: IconType.card,
    title: StaticStrings.cardDraw,
    route: RouteName.cardDraw,
  ),
  MenuItem(
    iconType: IconType.group,
    title: StaticStrings.groupBuilder,
    route: RouteName.groupBuilder,
  ),
  MenuItem(
    iconType: IconType.list,
    title: StaticStrings.listRandomizer,
    route: RouteName.listRandomizer,
  ),
  MenuItem(
    iconType: IconType.password,
    title: StaticStrings.passwordGenerator,
    route: RouteName.passwordGenerator,
  ),
  MenuItem(
    iconType: IconType.color,
    title: StaticStrings.randomColor,
    route: RouteName.randomColor,
  ),
  MenuItem(
    iconType: IconType.letter,
    title: StaticStrings.randomLetter,
    route: RouteName.randomLetter,
  ),
  MenuItem(
    iconType: IconType.word,
    title: StaticStrings.randomWord,
    route: RouteName.randomWord,
  ),
  MenuItem(
    iconType: IconType.date,
    title: StaticStrings.randomDate,
    route: RouteName.randomDate,
  ),
  MenuItem(
    iconType: IconType.time,
    title: StaticStrings.randomTime,
    route: RouteName.randomTime,
  ),
  MenuItem(
    iconType: IconType.animal,
    title: StaticStrings.randomAnimal,
    route: RouteName.randomAnimal,
  ),
];
