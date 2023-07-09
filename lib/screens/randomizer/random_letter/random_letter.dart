import 'package:flutter/material.dart';
import 'package:randomizer/static/strings.dart';

class RandomLetterScreen extends StatefulWidget {
  const RandomLetterScreen({super.key});

  @override
  State<RandomLetterScreen> createState() => _RandomLetterScreenState();
}

class _RandomLetterScreenState extends State<RandomLetterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StaticStrings.randomLetter),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Random Letter',
            ),
          ],
        ),
      ),
    );
  }
}
