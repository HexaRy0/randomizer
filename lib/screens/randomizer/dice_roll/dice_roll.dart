import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:randomizer/providers/dice_roll_provider.dart';
import 'package:randomizer/static/strings.dart';

class DiceRollScreen extends ConsumerStatefulWidget {
  const DiceRollScreen({super.key});

  @override
  ConsumerState<DiceRollScreen> createState() => _DiceRollScreenState();
}

class _DiceRollScreenState extends ConsumerState<DiceRollScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  Widget _generateDice(BuildContext context, int value) {
    final IconData dice;

    switch (value) {
      case 1:
        dice = FontAwesomeIcons.diceOne;
        break;
      case 2:
        dice = FontAwesomeIcons.diceTwo;
        break;
      case 3:
        dice = FontAwesomeIcons.diceThree;
        break;
      case 4:
        dice = FontAwesomeIcons.diceFour;
        break;
      case 5:
        dice = FontAwesomeIcons.diceFive;
        break;
      case 6:
        dice = FontAwesomeIcons.diceSix;
        break;
      default:
        dice = FontAwesomeIcons.diceD6;
    }

    return FaIcon(
      dice,
      color: Theme.of(context).colorScheme.primaryContainer,
      size: 116,
    );
  }

  @override
  Widget build(BuildContext context) {
    final diceRoll = ref.watch(diceRollProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(StaticStrings.diceRoll),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Dice Roll"),
        icon: const Icon(Icons.shuffle),
        onPressed: () {
          FocusScope.of(context).unfocus();

          if (_formKey.currentState!.saveAndValidate()) {
            final diceType = int.parse(_formKey.currentState!.value['diceType']);
            final amount = int.parse(_formKey.currentState!.value['amount']);

            ref.read(diceRollProvider.notifier).rollDice(diceType, amount);
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
                name: 'diceType',
                decoration: const InputDecoration(
                  labelText: 'Dice Type',
                  border: OutlineInputBorder(),
                ),
                initialValue: '6',
                items: const [
                  DropdownMenuItem(
                    value: '6',
                    child: Text('D6 (6 Sided Dice)'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              FormBuilderTextField(
                name: 'amount',
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Amount Dice Rolled (1 - 1000)',
                  border: OutlineInputBorder(),
                ),
                initialValue: "9",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }

                  if (int.parse(value) < 1 || int.parse(value) > 1000) {
                    return 'Please enter a value between 1 and 1000';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Card(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                ),
                                itemBuilder: (context, index) => Center(
                                  child: _generateDice(context, diceRoll[index]),
                                ),
                                itemCount: diceRoll.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          diceRoll.isEmpty
                              ? Container()
                              : Text(
                                  'Total: ${diceRoll.reduce((value, element) => value + element)}',
                                  style: Theme.of(context).textTheme.headlineMedium,
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
      ),
    );
  }
}
