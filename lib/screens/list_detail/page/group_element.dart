import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Amount Group Generated',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter amount group generated';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter valid number (integer)';
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
                    child: Stack(
                      children: [
                        Center(
                          child: groupBuilder.isEmpty
                              ? FaIcon(
                                  FontAwesomeIcons.userGroup,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer
                                      .withOpacity(0.5),
                                  size: 128,
                                )
                              : SingleChildScrollView(
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
                                            child: Stack(
                                              children: [
                                                Center(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        padding: const EdgeInsets.symmetric(
                                                          horizontal: 8,
                                                          vertical: 4,
                                                        ),
                                                        decoration: BoxDecoration(
                                                          color: Theme.of(context)
                                                              .colorScheme
                                                              .primaryContainer,
                                                          borderRadius: BorderRadius.circular(4),
                                                        ),
                                                        child: Text(
                                                          "Group ${groupBuilder.indexOf(group) + 1}",
                                                          style:
                                                              Theme.of(context).textTheme.bodyLarge,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Text(
                                                        group.items.join(', '),
                                                        style:
                                                            Theme.of(context).textTheme.bodyLarge,
                                                      ),
                                                    ],
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
                                                          text:
                                                              "Group ${index + 1}: ${group.items.join(', ')}",
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                        ),
                        groupBuilder.length <= 1
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
                                          text: groupBuilder
                                              .map((e) =>
                                                  "Group ${groupBuilder.indexOf(e) + 1}: ${e.items.join(', ')}")
                                              .join('\n'),
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
