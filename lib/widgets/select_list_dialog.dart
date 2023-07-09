import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:randomizer/providers/async_group_list_provider.dart';
import 'package:randomizer/providers/selected_group_list_provider.dart';
import 'package:randomizer/screens/add_group_list/add_group_list.dart';

class SelectListDialog extends ConsumerStatefulWidget {
  const SelectListDialog({super.key});

  @override
  ConsumerState<SelectListDialog> createState() => _SelectListDialogState();
}

class _SelectListDialogState extends ConsumerState<SelectListDialog> {
  @override
  Widget build(BuildContext context) {
    final groupLists = ref.watch(asyncGroupListProvider);

    return AlertDialog(
      title: const Text('Select Group List'),
      content: groupLists.when(
        skipLoadingOnRefresh: true,
        skipLoadingOnReload: true,
        data: (groupList) => SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemCount: groupList.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final item = groupList[index];

                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text(
                      item.items.join(', '),
                      overflow: TextOverflow.ellipsis,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                    onTap: () {
                      ref.read(selectedGroupListProvider.notifier).selectGroupList(item);
                      Navigator.pop(context);
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        ref.read(asyncGroupListProvider.notifier).deleteGroupList(item);
                        ref.read(selectedGroupListProvider.notifier).selectGroupList(null);
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                label: const Text('New List'),
                icon: const Icon(Icons.add),
                onPressed: () async {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddGroupListScreen(
                        isFromOtherScreen: true,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}
