import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:randomizer/model/group_list.dart';
import 'package:randomizer/providers/list_detail_provider.dart';

class PickElement extends ConsumerStatefulWidget {
  const PickElement({super.key, required this.groupList});

  final GroupList groupList;

  @override
  ConsumerState<PickElement> createState() => _PickElementState();
}

class _PickElementState extends ConsumerState<PickElement> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final listDetail = ref.watch(listDetailProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_formKey.currentState!.saveAndValidate()) {
            ref.read(listDetailProvider.notifier).pickElement(
                  widget.groupList,
                  (_formKey.currentState!.fields["amount"]!.value as double).toInt(),
                );
          }
        },
        icon: const Icon(Icons.shuffle),
        label: const Text("Pick Element"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilderSlider(
                  name: "amount",
                  initialValue: 1,
                  min: widget.groupList.items.length == 1 ? 0 : 1,
                  max: widget.groupList.items.length.toDouble(),
                  divisions:
                      widget.groupList.items.length == 1 ? 1 : widget.groupList.items.length - 1,
                  maxValueWidget: (max) => Container(),
                  valueWidget: (value) => Text("$value elements"),
                  minValueWidget: (min) => Container(),
                  decoration: const InputDecoration(
                    labelText: "Amount Element Picked",
                    border: InputBorder.none,
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                      child: SingleChildScrollView(
                        child: listDetail.isEmpty
                            ? Column(
                                children: [
                                  Icon(
                                    Icons.category,
                                    size: 128,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer
                                        .withOpacity(0.5),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    "No Element Picked",
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimaryContainer
                                              .withOpacity(0.5),
                                        ),
                                  ),
                                ],
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                itemCount: listDetail.length,
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
                                                listDetail[index].toString(),
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context).textTheme.titleLarge,
                                              ),
                                            ),
                                            Positioned(
                                              right: 0,
                                              child: IconButton.filled(
                                                style: ButtonStyle(
                                                  backgroundColor: MaterialStateProperty.all<Color>(
                                                    Theme.of(context).colorScheme.primaryContainer,
                                                  ),
                                                  foregroundColor: MaterialStateProperty.all<Color>(
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .onPrimaryContainer,
                                                  ),
                                                ),
                                                icon: const Icon(Icons.copy),
                                                onPressed: () async {
                                                  await Clipboard.setData(
                                                    ClipboardData(
                                                      text: listDetail[index].toString(),
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
