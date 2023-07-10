import 'package:flutter/material.dart';
import 'package:randomizer/static/menu_item.dart';
import 'package:randomizer/static/route_name.dart';
import 'package:randomizer/static/strings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                  value: "about",
                  child: Text("About"),
                ),
                PopupMenuItem(
                  value: "settings",
                  child: Text("Settings"),
                ),
              ];
            },
            onSelected: (value) {
              switch (value) {
                case "about":
                  Navigator.pushNamed(context, RouteName.about);
                  break;
                case "settings":
                  Navigator.pushNamed(context, RouteName.settings);
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
                        child: Center(
                          child: Text(
                            item.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                            ),
                          ),
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
