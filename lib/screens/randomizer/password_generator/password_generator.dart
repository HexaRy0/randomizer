import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:randomizer/providers/password_generator_provider.dart';
import 'package:randomizer/static/strings.dart';

class PasswordGeneratorScreen extends ConsumerStatefulWidget {
  const PasswordGeneratorScreen({super.key});

  @override
  ConsumerState<PasswordGeneratorScreen> createState() => _PasswordGeneratorScreenState();
}

class _PasswordGeneratorScreenState extends ConsumerState<PasswordGeneratorScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final passwordGenerator = ref.watch(passwordGeneratorProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(StaticStrings.passwordGenerator),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Generate Password"),
        icon: const Icon(Icons.shuffle),
        onPressed: () {
          if (_formKey.currentState!.saveAndValidate()) {
            final length = int.parse(_formKey.currentState!.value['length']);
            final includes = _formKey.currentState!.value['include'];

            ref.read(passwordGeneratorProvider.notifier).generatePassword(length, includes);
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
                name: 'length',
                initialValue: "8",
                decoration: const InputDecoration(
                  labelText: 'Password Length',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              FormBuilderFilterChip(
                name: 'include',
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                spacing: 8,
                initialValue: const ["uppercase", "lowercase", "numbers", "symbols"],
                alignment: WrapAlignment.center,
                options: const [
                  FormBuilderChipOption(
                    value: "uppercase",
                    child: Text("Uppercase"),
                  ),
                  FormBuilderChipOption(
                    value: "lowercase",
                    child: Text("Lowercase"),
                  ),
                  FormBuilderChipOption(
                    value: "numbers",
                    child: Text("Number"),
                  ),
                  FormBuilderChipOption(
                    value: "symbols",
                    child: Text("Symbol"),
                  ),
                ],
              ),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Text(
                          passwordGenerator,
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
