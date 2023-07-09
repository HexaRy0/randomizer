import 'package:flutter/material.dart';
import 'package:randomizer/static/strings.dart';

class ListRandomizerScreen extends StatefulWidget {
  const ListRandomizerScreen({super.key});

  @override
  State<ListRandomizerScreen> createState() => _ListRandomizerScreenState();
}

class _ListRandomizerScreenState extends State<ListRandomizerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StaticStrings.listRandomizer),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'List Randomizer',
            ),
          ],
        ),
      ),
    );
  }
}
