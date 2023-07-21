import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        actions: [
          IconButton(
            icon: const Icon(Icons.restore_rounded),
            onPressed: () {
              FocusScope.of(context).unfocus();
              _formKey.currentState!.reset();
              ref.read(randomAnimalProvider.notifier).reset();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Generate Animal"),
        icon: const Icon(Icons.shuffle),
        onPressed: () {
          FocusScope.of(context).unfocus();
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
                  labelText: "Amount animal generated (1 - 500)",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter amount of animal generated';
                  }

                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number (integer)';
                  }

                  if (int.parse(value) < 1 || int.parse(value) > 500) {
                    return 'Please enter amount of animal generated between 1 and 500';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Center(
                          child: SingleChildScrollView(
                            child: randomAnimal.isEmpty
                                ? FaIcon(
                                    FontAwesomeIcons.dog,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer
                                        .withOpacity(0.5),
                                    size: 128,
                                  )
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
                                            child: Stack(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.all(8),
                                                  width: double.infinity,
                                                  child: Text(
                                                    randomAnimal[index],
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context).textTheme.titleLarge,
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 0,
                                                  child: IconButton.filled(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty.all<Color>(
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .primaryContainer,
                                                      ),
                                                      foregroundColor:
                                                          MaterialStateProperty.all<Color>(
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .onPrimaryContainer,
                                                      ),
                                                    ),
                                                    icon: const Icon(Icons.copy),
                                                    onPressed: () async {
                                                      await Clipboard.setData(
                                                        ClipboardData(
                                                          text: randomAnimal[index].toString(),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ),
                        randomAnimal.length <= 1
                            ? Container()
                            : Positioned(
                                bottom: 0,
                                left: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton.icon(
                                    label: const Text("Copy All"),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(
                                        Theme.of(context).colorScheme.primaryContainer,
                                      ),
                                      foregroundColor: MaterialStateProperty.all<Color>(
                                        Theme.of(context).colorScheme.onPrimaryContainer,
                                      ),
                                    ),
                                    icon: const Icon(Icons.copy),
                                    onPressed: () async {
                                      await Clipboard.setData(
                                        ClipboardData(
                                          text: randomAnimal.join(", ").toString(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                      ],
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
