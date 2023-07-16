import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:randomizer/providers/card_draw_provider.dart';
import 'package:randomizer/static/strings.dart';

class CardDrawScreen extends ConsumerStatefulWidget {
  const CardDrawScreen({super.key});

  @override
  ConsumerState<CardDrawScreen> createState() => _CardDrawScreenState();
}

class _CardDrawScreenState extends ConsumerState<CardDrawScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final cardDraw = ref.watch(cardDrawProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(StaticStrings.cardDraw),
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
                  labelText: 'Amount Card Drawn (1 - 1000)',
                  border: OutlineInputBorder(),
                ),
                initialValue: "1",
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                  FormBuilderValidators.min(1),
                  FormBuilderValidators.max(1000),
                ]),
              ),
              FormBuilderCheckbox(
                name: 'unique',
                title: const Text('Unique'),
                initialValue: false,
              ),
              Expanded(
                child: Card(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ...cardDraw.map(
                              (e) => Text(
                                e,
                                style: Theme.of(context).textTheme.headlineLarge,
                              ),
                            ),
                          ],
                        ),
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
