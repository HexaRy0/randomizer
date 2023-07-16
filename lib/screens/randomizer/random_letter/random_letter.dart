import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:randomizer/providers/random_letter_provider.dart';
import 'package:randomizer/static/strings.dart';

class RandomLetterScreen extends ConsumerStatefulWidget {
  const RandomLetterScreen({super.key});

  @override
  ConsumerState<RandomLetterScreen> createState() => _RandomLetterScreenState();
}

class _RandomLetterScreenState extends ConsumerState<RandomLetterScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final randomLetter = ref.watch(randomLetterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(StaticStrings.randomLetter),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Generate Letter"),
        icon: const Icon(Icons.shuffle),
        onPressed: () {
          if (_formKey.currentState!.saveAndValidate()) {
            ref.read(randomLetterProvider.notifier).generateRandomLetter(
                  int.parse(_formKey.currentState!.value['amount'] as String),
                  _formKey.currentState!.value['type'] as String,
                );
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'amount',
                initialValue: "1",
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Amount letter generated",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              FormBuilderDropdown(
                name: 'type',
                initialValue: "both",
                decoration: const InputDecoration(
                  labelText: "Type of letter",
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: "uppercase",
                    child: Text("Uppercase Only"),
                  ),
                  DropdownMenuItem(
                    value: "lowercase",
                    child: Text("Lowercase Only"),
                  ),
                  DropdownMenuItem(
                    value: "both",
                    child: Text("Both Uppercase and Lowercase"),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: SingleChildScrollView(
                        child: randomLetter.isEmpty
                            ? const Text("Press the button to generate letter")
                            : ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                itemCount: randomLetter.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Card(
                                      color: Theme.of(context).colorScheme.secondaryContainer,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Text(
                                          randomLetter[index],
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context).textTheme.titleLarge,
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
              ),
              const SizedBox(height: 72),
            ],
          ),
        ),
      ),
    );
  }
}
