import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:randomizer/static/menu_item.dart';
import 'package:randomizer/static/route_name.dart';
import 'package:randomizer/static/strings.dart';

import 'package:randomizer/helper/icon_type.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _generateIcon(BuildContext context, IconType iconType) {
    final Widget widget;

    switch (iconType) {
      case IconType.number:
        widget = Icon(
          Icons.numbers,
          size: 96,
          color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.5),
        );
        break;
      case IconType.coin:
        widget = FaIcon(
          FontAwesomeIcons.coins,
          color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.5),
          size: 96,
        );
        break;
      case IconType.dice:
        widget = FaIcon(
          FontAwesomeIcons.diceD6,
          color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.5),
          size: 96,
        );
        break;
      case IconType.card:
        widget = Transform.rotate(
          angle: .25,
          child: Container(
            width: 80,
            height: 120,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SizedBox(
              child: Image.asset(
                "assets/images/card/spades.png",
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
          ),
        );
        break;
      case IconType.group:
        widget = FaIcon(
          FontAwesomeIcons.userGroup,
          color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.5),
          size: 96,
        );
        break;
      case IconType.list:
        widget = FaIcon(
          FontAwesomeIcons.list,
          color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.5),
          size: 96,
        );
        break;
      case IconType.password:
        widget = FaIcon(
          FontAwesomeIcons.key,
          color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.5),
          size: 96,
        );
        break;
      case IconType.color:
        widget = FaIcon(
          FontAwesomeIcons.palette,
          color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.5),
          size: 96,
        );
        break;
      case IconType.letter:
        widget = FaIcon(
          FontAwesomeIcons.font,
          color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.5),
          size: 96,
        );
        break;
      case IconType.word:
        widget = FaIcon(
          FontAwesomeIcons.book,
          color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.5),
          size: 96,
        );
        break;
      case IconType.date:
        widget = FaIcon(
          FontAwesomeIcons.calendarDay,
          color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.5),
          size: 96,
        );
        break;
      case IconType.time:
        widget = FaIcon(
          FontAwesomeIcons.clock,
          color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.5),
          size: 96,
        );
        break;
      case IconType.animal:
        widget = FaIcon(
          FontAwesomeIcons.dog,
          color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.5),
          size: 96,
        );
        break;
      default:
        widget = Icon(
          Icons.help,
          size: 96,
          color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.5),
        );
    }

    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StaticStrings.appName),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return const [
                PopupMenuItem(
                  value: "settings",
                  child: Text("Settings"),
                ),
                PopupMenuItem(
                  value: "about",
                  child: Text("About"),
                ),
              ];
            },
            onSelected: (value) {
              switch (value) {
                case "settings":
                  Navigator.pushNamed(context, RouteName.settings);
                  break;
                case "about":
                  Navigator.pushNamed(context, RouteName.about);
                  break;
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
          ),
          children: [
            ...menuItem
                .map(
                  (item) => Card(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        Navigator.pushNamed(context, item.route);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _generateIcon(context, item.iconType),
                            Text(
                              item.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}
