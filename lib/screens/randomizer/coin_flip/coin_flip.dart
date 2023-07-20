import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:randomizer/helper/string_extension.dart';
import 'package:randomizer/providers/coin_flip_provider.dart';
import 'package:randomizer/static/strings.dart';

class CoinFlipScreen extends ConsumerStatefulWidget {
  const CoinFlipScreen({super.key});

  @override
  ConsumerState<CoinFlipScreen> createState() => _CoinFlipScreenState();
}

class _CoinFlipScreenState extends ConsumerState<CoinFlipScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    super.initState();
  }

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
        onPressed: () {
          _controller.forward(from: 0);
          ref.read(coinFlipProvider.notifier).flipCoin();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Card(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        coinFlip == ""
                            ? FaIcon(
                                FontAwesomeIcons.coins,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer
                                    .withOpacity(0.5),
                                size: 128,
                              )
                            : AnimatedBuilder(
                                animation: _animation,
                                child: Image.asset(
                                  "assets/images/coin/$coinFlip.png",
                                  key: ValueKey(coinFlip),
                                  width: 200,
                                ),
                                builder: (context, child) {
                                  return Opacity(
                                    opacity: _animation.value,
                                    child: Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.rotationY(_animation.value * 3.14 * 2),
                                      child: child,
                                    ),
                                  );
                                },
                              ),
                        const SizedBox(
                          height: 32,
                        ),
                        coinFlip == ""
                            ? Container()
                            : AnimatedBuilder(
                                animation: _animation,
                                child: Text(
                                  coinFlip.capitalize(),
                                  style: Theme.of(context).textTheme.displayMedium,
                                ),
                                builder: (context, child) {
                                  return Opacity(
                                    opacity: _animation.value,
                                    child: Transform.translate(
                                      offset: Offset(0, _animation.value * -16),
                                      child: child,
                                    ),
                                  );
                                },
                              ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 72,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
