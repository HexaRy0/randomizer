import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:randomizer/model/group_list.dart';
import 'package:randomizer/providers/list_detail_provider.dart';

class ShuffleElement extends ConsumerStatefulWidget {
  const ShuffleElement({super.key, required this.groupList});

  final GroupList groupList;

  @override
  ConsumerState<ShuffleElement> createState() => _ShuffleElementState();
}

class _ShuffleElementState extends ConsumerState<ShuffleElement> {
  @override
  Widget build(BuildContext context) {
    final listDetail = ref.watch(listDetailProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
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
                                  Icons.shuffle,
                                  size: 128,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer
                                      .withOpacity(0.5),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  "Shuffle List",
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
                                                color:
                                                    Theme.of(context).colorScheme.primaryContainer,
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
                                                  Theme.of(context).colorScheme.onPrimaryContainer,
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ref.read(listDetailProvider.notifier).shuffleElements(widget.groupList);
        },
        icon: const Icon(Icons.shuffle),
        label: const Text("Shuffle List"),
      ),
    );
  }
}
