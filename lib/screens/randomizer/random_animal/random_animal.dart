import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:randomizer/providers/random_animal_provider.dart';
import 'package:randomizer/static/strings.dart';

class RandomAnimalScreen extends ConsumerStatefulWidget {
  const RandomAnimalScreen({super.key});

  @override
  ConsumerState<RandomAnimalScreen> createState() => _RandomAnimalScreenState();
}

class _RandomAnimalScreenState extends ConsumerState<RandomAnimalScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final randomAnimal = ref.watch(randomAnimalProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(StaticStrings.randomAnimal),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Generate Animal"),
        icon: const Icon(Icons.shuffle),
        onPressed: () {
          if (_formKey.currentState!.saveAndValidate()) {
            ref.read(randomAnimalProvider.notifier).generateRandomAnimal(
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
                  labelText: "Amount animal generated",
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
                        child: randomAnimal.isEmpty
                            ? const Text("Press the button to generate animal")
                            : ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                itemCount: randomAnimal.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Card(
                                      color: Theme.of(context).colorScheme.secondaryContainer,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Text(
                                          randomAnimal[index],
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
