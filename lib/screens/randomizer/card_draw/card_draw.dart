import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:randomizer/providers/card_draw_provider.dart';
import 'package:randomizer/static/strings.dart';

class CardDrawScreen extends ConsumerStatefulWidget {
  const CardDrawScreen({super.key});

  @override
  ConsumerState<CardDrawScreen> createState() => _CardDrawScreenState();
}

class _CardDrawScreenState extends ConsumerState<CardDrawScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  Widget _generateCardSymbol(String symbolName) {
    final ImageProvider image;

    switch (symbolName) {
      case "Spades":
        image = const AssetImage("assets/images/card/spades.png");
        break;
      case "Hearts":
        image = const AssetImage("assets/images/card/heart.png");
        break;
      case "Diamonds":
        image = const AssetImage("assets/images/card/diamond.png");
        break;
      case "Clubs":
        image = const AssetImage("assets/images/card/club.png");
        break;
      default:
        image = const AssetImage("assets/images/card/spades.png");
    }

    return Image(
      image: image,
      width: 24,
      height: 24,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cardDraw = ref.watch(cardDrawProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(StaticStrings.cardDraw),
        actions: [
          IconButton(
            icon: const Icon(Icons.restore_rounded),
            onPressed: () {
              FocusScope.of(context).unfocus();
              _formKey.currentState!.reset();
              ref.read(cardDrawProvider.notifier).reset();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Draw Card"),
        icon: const Icon(Icons.shuffle),
        onPressed: () {
          FocusScope.of(context).unfocus();

          if (_formKey.currentState!.saveAndValidate()) {
            final deckType = _formKey.currentState!.value['deckType'] ?? false;
            final amount = int.parse(_formKey.currentState!.value['amount']);
            final unique = _formKey.currentState!.value['unique'] ?? false;

            ref.read(cardDrawProvider.notifier).drawCard(deckType, amount, unique);
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderDropdown(
                name: 'deckType',
                decoration: const InputDecoration(
                  labelText: 'Deck Type',
                  border: OutlineInputBorder(),
                ),
                initialValue: 'standard',
                items: const [
                  DropdownMenuItem(
                    value: 'standard',
                    child: Text('Standard Deck (52 Cards)'),
                  ),
                  DropdownMenuItem(
                    value: 'standard-joker',
                    child: Text('Standard Deck with 2 Joker'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              FormBuilderTextField(
                name: 'amount',
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Amount Card Drawn (1 - 500)',
                  border: OutlineInputBorder(),
                ),
                initialValue: "1",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter amount of card drawn';
                  }

                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number (integer)';
                  }

                  if (int.parse(value) < 1 || int.parse(value) > 500) {
                    return 'Please enter amount of card drawn between 1 and 500';
                  }

                  return null;
                },
              ),
              FormBuilderCheckbox(
                name: 'unique',
                initialValue: false,
                title: const Text('Unique'),
                validator: (value) {
                  if (value == true) {
                    if ((int.tryParse(_formKey.currentState!.value['amount']) ?? 0) >
                        (_formKey.currentState!.value['deckType'] == "standard" ? 52 : 54)) {
                      return 'Unique card only available for less than or equal to ${_formKey.currentState!.value['deckType'] == "standard" ? 52 : 54}';
                    }
                  }

                  return null;
                },
              ),
              Expanded(
                child: Card(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: cardDraw.isEmpty
                          ? Transform.rotate(
                              angle: .25,
                              child: Container(
                                width: 80,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.secondaryContainer,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: SizedBox(
                                  child: Image.asset(
                                    "assets/images/card/spades.png",
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondaryContainer
                                        .withOpacity(0.25),
                                  ),
                                ),
                              ),
                            )
                          : GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 3 / 4,
                              ),
                              itemCount: cardDraw.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Card(
                                    color: Theme.of(context).colorScheme.secondaryContainer,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        width: double.infinity,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            !cardDraw[index].contains("Joker")
                                                ? _generateCardSymbol(
                                                    cardDraw[index].split(" of ").last)
                                                : Container(),
                                            const SizedBox(height: 8),
                                            Text(
                                              cardDraw[index].split(" of ").first,
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context).textTheme.titleLarge,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 72),
            ],
          ),
        ),
      ),
    );
  }
}
