import 'package:flutter/material.dart';

class RandomizerScreen extends StatefulWidget {
  const RandomizerScreen({super.key, required this.title, required this.body});

  final String title;
  final Widget body;

  @override
  State<RandomizerScreen> createState() => _RandomizerScreenState();
}

class _RandomizerScreenState extends State<RandomizerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: widget.body,
    );
  }
}
