import 'package:flutter/material.dart';
import 'package:randomizer/static/strings.dart';

class DiceRollScreen extends StatefulWidget {
  const DiceRollScreen({super.key});

  @override
  State<DiceRollScreen> createState() => _DiceRollScreenState();
}

class _DiceRollScreenState extends State<DiceRollScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StaticStrings.diceRoll),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Dice Roll',
            ),
          ],
        ),
      ),
    );
  }
}
