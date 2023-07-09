import 'package:flutter/material.dart';
import 'package:randomizer/static/strings.dart';

class RandomColorScreen extends StatefulWidget {
  const RandomColorScreen({super.key});

  @override
  State<RandomColorScreen> createState() => _RandomColorScreenState();
}

class _RandomColorScreenState extends State<RandomColorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StaticStrings.randomColor),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Random Color',
            ),
          ],
        ),
      ),
    );
  }
}
