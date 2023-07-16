import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:randomizer/model/group_list.dart';
import 'package:randomizer/providers/group_builder_provider.dart';

class GroupElement extends ConsumerStatefulWidget {
  const GroupElement({super.key, required this.groupList});

  final GroupList groupList;

  @override
  ConsumerState<GroupElement> createState() => _GroupElementState();
}

class _GroupElementState extends ConsumerState<GroupElement> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final groupBuilder = ref.watch(groupBuilderProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_formKey.currentState!.saveAndValidate()) {
            ref.read(groupBuilderProvider.notifier).generateGroupList(
                  widget.groupList,
                  int.parse(_formKey.currentState!.value['amount']),
                );
          }
        },
        icon: const Icon(Icons.shuffle),
        label: const Text("Generate Group"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderTextField(
                  name: 'amount',
                  initialValue: "3",
                  decoration: const InputDecoration(
                    labelText: 'Amount Group Generated',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter amount group generated';
                    }
                    if (int.tryParse(value)! > widget.groupList.items.length) {
                      return 'Value are more than total item in list';
                    }

                    return null;
                  },
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                      child: SingleChildScrollView(
                        child: ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: groupBuilder.length,
                          itemBuilder: (context, index) {
                            final group = groupBuilder[index];
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: Card(
                                color: Theme.of(context).colorScheme.secondaryContainer,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Group ${groupBuilder.indexOf(group) + 1}",
                                        style: Theme.of(context).textTheme.bodyLarge,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(group.items.join(', ')),
                                    ],
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
