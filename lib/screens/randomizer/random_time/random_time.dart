import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:randomizer/providers/random_time_provider.dart';
import 'package:randomizer/static/strings.dart';

class RandomTimeScreen extends ConsumerStatefulWidget {
  const RandomTimeScreen({super.key});

  @override
  ConsumerState<RandomTimeScreen> createState() => _RandomTimeScreenState();
}

class _RandomTimeScreenState extends ConsumerState<RandomTimeScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final randomTime = ref.watch(randomTimeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(StaticStrings.randomTime),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Generate Time"),
        icon: const Icon(Icons.shuffle),
        onPressed: () {
          if (_formKey.currentState!.saveAndValidate()) {
            ref.read(randomTimeProvider.notifier).generateRandomTime(
                  int.parse(_formKey.currentState!.value['amount'] as String),
                  _formKey.currentState!.value['startTime'] as DateTime,
                  _formKey.currentState!.value['endTime'] as DateTime,
                  _formKey.currentState!.value['unique'] as bool,
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
                  labelText: "Amount time generated",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter amount of time generated';
                  }

                  if (int.parse(value) < 1 || int.parse(value) > 1000) {
                    return 'Please enter amount of time generated between 1 and 1000';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: FormBuilderDateTimePicker(
                      name: 'startTime',
                      initialValue: DateTime.now(),
                      inputType: InputType.time,
                      decoration: const InputDecoration(
                        labelText: "Start Time",
                        border: OutlineInputBorder(),
                      ),
                      valueTransformer: (value) {
                        if (value != null) {
                          return DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            value.hour,
                            value.minute,
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FormBuilderDateTimePicker(
                      name: 'endTime',
                      initialValue: DateTime.now().add(const Duration(minutes: 10)),
                      inputType: InputType.time,
                      decoration: const InputDecoration(
                        labelText: "End Time",
                        border: OutlineInputBorder(),
                      ),
                      valueTransformer: (value) {
                        if (value != null) {
                          return DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            value.hour,
                            value.minute,
                          );
                        }
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
                    if (int.parse(_formKey.currentState!.value['amount'] as String) >
                        (_formKey.currentState!.value['endTime'] as DateTime)
                            .difference(_formKey.currentState!.value['startTime'] as DateTime)
                            .inMinutes) {
                      return 'Unique time only available for less than or equal to ${(_formKey.currentState!.value['endTime'] as DateTime).difference(_formKey.currentState!.value['startTime'] as DateTime).inMinutes}';
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
                            child: randomTime.isEmpty
                                ? const Text("Press the button to generate time")
                                : ListView.builder(
                                    shrinkWrap: true,
                                    primary: false,
                                    itemCount: randomTime.length,
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
                                                    randomTime[index],
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
                                                          text: randomTime[index].toString(),
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
                        randomTime.length <= 1
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
                                          text: randomTime.join(", ").toString(),
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
