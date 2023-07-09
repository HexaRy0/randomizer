import 'package:flutter/material.dart';
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
                  labelText: 'Amount Number Generated (1 - 1000)',
                  border: OutlineInputBorder(),
                ),
                initialValue: "1",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a amount value';
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
                          return 'Please enter a minimum number';
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
                          return 'Please enter a maximum number';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
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
                        child: Text(
                          randomNumber.toString(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineLarge,
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
