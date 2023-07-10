import 'package:flutter/material.dart';
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
                          ? const Text("Press button below to start shuffle list")
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
                                      child: Text(
                                        listDetail[index],
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
