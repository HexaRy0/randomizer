import 'package:flutter/material.dart';
import 'package:randomizer/static/strings.dart';

class RandomAnimalScreen extends StatefulWidget {
  const RandomAnimalScreen({super.key});

  @override
  State<RandomAnimalScreen> createState() => _RandomAnimalScreenState();
}

class _RandomAnimalScreenState extends State<RandomAnimalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StaticStrings.randomAnimal),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Random Animal',
            ),
          ],
        ),
      ),
    );
  }
}
