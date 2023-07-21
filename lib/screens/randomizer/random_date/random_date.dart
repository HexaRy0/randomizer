import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
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
        title: const Text(StaticStrings.randomDate),
        actions: [
          IconButton(
            icon: const Icon(Icons.restore_rounded),
            onPressed: () {
              FocusScope.of(context).unfocus();
              _formKey.currentState!.reset();
              ref.read(randomDateProvider.notifier).reset();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Generate Date"),
        icon: const Icon(Icons.shuffle),
        onPressed: () {
          FocusScope.of(context).unfocus();
          if (_formKey.currentState!.saveAndValidate()) {
            ref.read(randomDateProvider.notifier).generateRandomDate(
                  int.parse(_formKey.currentState!.value['amount'] as String),
                  _formKey.currentState!.value['startDate'] as DateTime,
                  _formKey.currentState!.value['endDate'] as DateTime,
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
                  labelText: "Amount date generated",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter amount date generated";
                  }

                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number (integer)';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: FormBuilderDateTimePicker(
                      name: 'startDate',
                      initialValue: DateTime.now(),
                      format: DateFormat('dd/MM/yyyy'),
                      inputType: InputType.date,
                      decoration: const InputDecoration(
                        labelText: "Start Date",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FormBuilderDateTimePicker(
                      name: 'endDate',
                      initialValue: DateTime.now().add(const Duration(days: 1)),
                      format: DateFormat('dd/MM/yyyy'),
                      inputType: InputType.date,
                      decoration: const InputDecoration(
                        labelText: "End Date",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              FormBuilderCheckbox(
                name: 'unique',
                initialValue: false,
                title: const Text("Unique"),
                validator: (value) {
                  if (value == true) {
                    if ((int.tryParse(_formKey.currentState!.value['amount'] as String) ?? 0) >
                        _formKey.currentState!.value['endDate']!
                                .difference(_formKey.currentState!.value['startDate'] as DateTime)
                                .inDays +
                            4) {
                      return "Amount date generated must be less than date range";
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
                            child: randomDate.isEmpty
                                ? FaIcon(
                                    FontAwesomeIcons.calendarDay,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer
                                        .withOpacity(0.5),
                                    size: 128,
                                  )
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
                                            child: Stack(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.all(8),
                                                  width: double.infinity,
                                                  child: Text(
                                                    randomDate[index],
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
                                                          text: randomDate[index].toString(),
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
                        randomDate.length <= 1
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
                                          text: randomDate.join(", ").toString(),
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
