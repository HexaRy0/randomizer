import 'package:flutter/material.dart';
import 'package:randomizer/static/strings.dart';

class RandomWordScreen extends StatefulWidget {
  const RandomWordScreen({super.key});

  @override
  State<RandomWordScreen> createState() => _RandomWordScreenState();
}

class _RandomWordScreenState extends State<RandomWordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StaticStrings.randomWord),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Random Word',
            ),
          ],
        ),
      ),
    );
  }
}
