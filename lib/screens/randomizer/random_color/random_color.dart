import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:randomizer/providers/random_color_provider.dart';
import 'package:randomizer/static/strings.dart';

class RandomColorScreen extends ConsumerStatefulWidget {
  const RandomColorScreen({super.key});

  @override
  ConsumerState<RandomColorScreen> createState() => _RandomColorScreenState();
}

class _RandomColorScreenState extends ConsumerState<RandomColorScreen> {
  @override
  Widget build(BuildContext context) {
    final randomColor = ref.watch(randomColorProvider);
    final redHex = randomColor.red.toRadixString(16).toUpperCase();
    final greenHex = randomColor.green.toRadixString(16).toUpperCase();
    final blueHex = randomColor.blue.toRadixString(16).toUpperCase();
    final hue = HSLColor.fromColor(randomColor).hue.round();
    final saturation = HSLColor.fromColor(randomColor).saturation.round();
    final lightness = HSLColor.fromColor(randomColor).lightness.round();

    final colorScheme = ColorScheme.fromSeed(
      seedColor: randomColor,
      brightness: Theme.of(context).brightness,
    );

    final textColorScheme = Theme.of(context).textTheme.headlineMedium!.copyWith(
          color: colorScheme.onPrimaryContainer,
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text(StaticStrings.randomColor),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.shuffle),
        label: const Text("Generate Color"),
        onPressed: () {
          ref.read(randomColorProvider.notifier).generateRandomColor();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Material(
                                elevation: 16,
                                borderRadius: BorderRadius.circular(16),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: 180,
                                  height: 180,
                                  decoration: BoxDecoration(
                                    color: randomColor,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "#$redHex$greenHex$blueHex",
                                    style: textColorScheme,
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.copy,
                                      color: colorScheme.onPrimaryContainer,
                                    ),
                                    onPressed: () async {
                                      await Clipboard.setData(
                                        ClipboardData(
                                          text: "#$redHex$greenHex$blueHex",
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "rgb(${randomColor.red}, ${randomColor.green}, ${randomColor.blue})",
                                    style: textColorScheme,
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.copy,
                                      color: colorScheme.onPrimaryContainer,
                                    ),
                                    onPressed: () {
                                      Clipboard.setData(
                                        ClipboardData(
                                          text:
                                              "rgb(${randomColor.red}, ${randomColor.green}, ${randomColor.blue})",
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "hsl($hue, $saturation%, $lightness%)",
                                    style: textColorScheme,
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.copy,
                                      color: colorScheme.onPrimaryContainer,
                                    ),
                                    onPressed: () {
                                      Clipboard.setData(
                                        ClipboardData(
                                          text: "hsl($hue, $saturation%, $lightness%)",
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "Background color is a primaryContainer variant from material you, the generated color are the color on the box.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: colorScheme.onPrimaryContainer,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 72),
          ],
        ),
      ),
    );
  }
}
