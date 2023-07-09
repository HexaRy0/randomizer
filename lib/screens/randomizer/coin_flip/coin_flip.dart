import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:randomizer/providers/coin_flip_provider.dart';
import 'package:randomizer/static/strings.dart';

class CoinFlipScreen extends ConsumerStatefulWidget {
  const CoinFlipScreen({super.key});

  @override
  ConsumerState<CoinFlipScreen> createState() => _CoinFlipScreenState();
}

class _CoinFlipScreenState extends ConsumerState<CoinFlipScreen> {
  @override
  Widget build(BuildContext context) {
    final coinFlip = ref.watch(coinFlipProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(StaticStrings.coinFlip),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Flip Coin"),
        icon: const Icon(Icons.shuffle),
        onPressed: () => ref.read(coinFlipProvider.notifier).flipCoin(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              coinFlip,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
      ),
    );
  }
}
