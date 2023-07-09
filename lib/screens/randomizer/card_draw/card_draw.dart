import 'package:flutter/material.dart';
import 'package:randomizer/static/strings.dart';

class CardDrawScreen extends StatefulWidget {
  const CardDrawScreen({super.key});

  @override
  State<CardDrawScreen> createState() => _CardDrawScreenState();
}

class _CardDrawScreenState extends State<CardDrawScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StaticStrings.cardDraw),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Card Draw',
            ),
          ],
        ),
      ),
    );
  }
}
