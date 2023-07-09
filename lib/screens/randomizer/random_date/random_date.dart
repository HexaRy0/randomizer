import 'package:flutter/material.dart';
import 'package:randomizer/static/strings.dart';

class RandomDateScreen extends StatefulWidget {
  const RandomDateScreen({super.key});

  @override
  State<RandomDateScreen> createState() => _RandomDateScreenState();
}

class _RandomDateScreenState extends State<RandomDateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StaticStrings.randomDate),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Random Date',
            ),
          ],
        ),
      ),
    );
  }
}
