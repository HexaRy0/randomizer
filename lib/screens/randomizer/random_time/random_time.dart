import 'package:flutter/material.dart';
import 'package:randomizer/static/strings.dart';

class RandomTimeScreen extends StatefulWidget {
  const RandomTimeScreen({super.key});

  @override
  State<RandomTimeScreen> createState() => _RandomTimeScreenState();
}

class _RandomTimeScreenState extends State<RandomTimeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StaticStrings.randomTime),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Random Time',
            ),
          ],
        ),
      ),
    );
  }
}
