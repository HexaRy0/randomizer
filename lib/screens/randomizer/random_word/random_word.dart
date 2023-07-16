import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:randomizer/providers/random_word_provider.dart';
import 'package:randomizer/static/strings.dart';

class RandomWordScreen extends ConsumerStatefulWidget {
  const RandomWordScreen({super.key});

  @override
  ConsumerState<RandomWordScreen> createState() => _RandomWordScreenState();
}

class _RandomWordScreenState extends ConsumerState<RandomWordScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final randomWord = ref.watch(randomWordProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(StaticStrings.randomWord),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Generate Letter"),
        icon: const Icon(Icons.shuffle),
        onPressed: () {
          if (_formKey.currentState!.saveAndValidate()) {
            ref.read(randomWordProvider.notifier).generateRandomWord(
                  int.parse(_formKey.currentState!.value['amount'] as String),
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
                  labelText: "Amount word generated",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: SingleChildScrollView(
                        child: randomWord.isEmpty
                            ? const Text("Press the button to generate letter")
                            : ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                itemCount: randomWord.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Card(
                                      color: Theme.of(context).colorScheme.secondaryContainer,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Text(
                                          randomWord[index],
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
