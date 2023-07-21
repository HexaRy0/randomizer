import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:randomizer/providers/random_number_provider.dart';

class RandomNumberScreen extends ConsumerStatefulWidget {
  const RandomNumberScreen({super.key});

  @override
  ConsumerState<RandomNumberScreen> createState() => _RandomNumberState();
}

class _RandomNumberState extends ConsumerState<RandomNumberScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final randomNumber = ref.watch(randomNumberProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Number'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Generate Number'),
        icon: const Icon(Icons.shuffle),
        onPressed: () {
          FocusScope.of(context).unfocus();

          if (_formKey.currentState!.saveAndValidate()) {
            final amount = int.parse(_formKey.currentState!.value['amount']);
            final minimum = int.parse(_formKey.currentState!.value['minimum']);
            final maximum = int.parse(_formKey.currentState!.value['maximum']);
            final unique = _formKey.currentState!.value['unique'] ?? false;

            ref.read(randomNumberProvider.notifier).generateRandomNumber(
                  amount,
                  minimum,
                  maximum,
                  unique,
                );
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'amount',
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Amount Number Generated (1 - 500)',
                  border: OutlineInputBorder(),
                ),
                initialValue: "1",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter amount of number generated';
                  }

                  if (int.tryParse(value) == null) {
                    return 'Please enter valid number (integer)';
                  }

                  if (int.parse(value) < 1 || int.parse(value) > 500) {
                    return 'Please enter amount of number generated between 1 and 500';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: FormBuilderTextField(
                      name: 'minimum',
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Minimum Number',
                        border: OutlineInputBorder(),
                      ),
                      initialValue: "1",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Minimum number is required";
                        }

                        if (int.tryParse(value) == null) {
                          return 'Please enter valid number (integer)';
                        }

                        if (int.parse(value) >
                            (int.tryParse(_formKey.currentState!.value['maximum']) ?? 0)) {
                          return "Must be less than maximum";
                        }

                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FormBuilderTextField(
                      name: 'maximum',
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Maximum Number',
                        border: OutlineInputBorder(),
                      ),
                      initialValue: "100",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Maximum number is required";
                        }

                        if (int.tryParse(value) == null) {
                          return 'Please enter valid number (integer)';
                        }

                        if (int.parse(value) <
                            (int.tryParse(_formKey.currentState!.value['minimum']) ?? 0)) {
                          return "Must be greater than minimum";
                        }

                        return null;
                      },
                    ),
                  ),
                ],
              ),
              FormBuilderCheckbox(
                name: 'unique',
                initialValue: false,
                title: const Text('Unique'),
                validator: (value) {
                  if (value == true) {
                    if ((int.tryParse(_formKey.currentState!.value['amount']) ?? 0) >
                        (int.tryParse(_formKey.currentState!.value['maximum']) ?? 0) -
                            (int.tryParse(_formKey.currentState!.value['minimum']) ?? 0)) {
                      return "Amount must be less than maximum - minimum";
                    }
                  }

                  return null;
                },
              ),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Center(
                          child: SingleChildScrollView(
                            child: randomNumber.isEmpty
                                ? Icon(
                                    Icons.numbers,
                                    size: 128,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer
                                        .withOpacity(0.5),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    primary: false,
                                    itemCount: randomNumber.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: Card(
                                          color: Theme.of(context).colorScheme.secondaryContainer,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  top: 0,
                                                  left: 0,
                                                  child: Container(
                                                    padding: const EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primaryContainer,
                                                      borderRadius: BorderRadius.circular(4),
                                                    ),
                                                    child: Text("${index + 1}"),
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.all(8),
                                                  width: double.infinity,
                                                  child: Text(
                                                    randomNumber[index].toString(),
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
                                                          text: randomNumber[index].toString(),
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
                        randomNumber.length <= 1
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
                                          text: randomNumber.join(", ").toString(),
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
