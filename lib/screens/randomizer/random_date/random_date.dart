import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:randomizer/providers/random_date_provider.dart';
import 'package:randomizer/static/strings.dart';

class RandomDateScreen extends ConsumerStatefulWidget {
  const RandomDateScreen({super.key});

  @override
  ConsumerState<RandomDateScreen> createState() => _RandomDateScreenState();
}

class _RandomDateScreenState extends ConsumerState<RandomDateScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final randomDate = ref.watch(randomDateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(StaticStrings.randomLetter),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Generate Date"),
        icon: const Icon(Icons.shuffle),
        onPressed: () {
          if (_formKey.currentState!.saveAndValidate()) {
            ref.read(randomDateProvider.notifier).generateRandomDate(
                  int.parse(_formKey.currentState!.value['amount'] as String),
                  _formKey.currentState!.value['startDate'] as DateTime,
                  _formKey.currentState!.value['endDate'] as DateTime,
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
                  labelText: "Amount date generated",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              FormBuilderDateTimePicker(
                name: 'startDate',
                initialValue: DateTime.now(),
                inputType: InputType.date,
                decoration: const InputDecoration(
                  labelText: "Start Date",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              FormBuilderDateTimePicker(
                name: 'endDate',
                initialValue: DateTime.now(),
                inputType: InputType.date,
                decoration: const InputDecoration(
                  labelText: "End Date",
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
                        child: randomDate.isEmpty
                            ? const Text("Press the button to generate date")
                            : ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                itemCount: randomDate.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Card(
                                      color: Theme.of(context).colorScheme.secondaryContainer,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Text(
                                          randomDate[index],
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
