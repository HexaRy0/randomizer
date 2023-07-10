import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:randomizer/model/group_list.dart';
import 'package:randomizer/providers/async_group_list_provider.dart';
import 'package:randomizer/providers/list_detail_provider.dart';
import 'package:randomizer/screens/list_detail/page/group_element.dart';
import 'package:randomizer/screens/list_detail/page/manage_element.dart';
import 'package:randomizer/screens/list_detail/page/pick_element.dart';
import 'package:randomizer/screens/list_detail/page/shuffle_element.dart';

class ListDetailScreen extends ConsumerStatefulWidget {
  const ListDetailScreen({super.key, required this.groupList});

  final GroupList groupList;

  @override
  ConsumerState<ListDetailScreen> createState() => _ListDetailScreenState();
}

class _ListDetailScreenState extends ConsumerState<ListDetailScreen> {
  int index = 0;
  late GroupList groupList;

  void _handleShowDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete List"),
          content: const Text("Are you sure you want to delete this list?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                ref.read(asyncGroupListProvider.notifier).deleteGroupList(widget.groupList);

                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final groupLists = ref.watch(asyncGroupListProvider);

    return groupLists.when(
      skipLoadingOnRefresh: true,
      skipLoadingOnReload: true,
      data: (groupList) {
        final list = groupList.firstWhere(
          (element) => element.id == widget.groupList.id,
          orElse: () => GroupList(
            name: "",
            items: [
              "",
            ],
          ),
        );

        return Scaffold(
          appBar: AppBar(
            title: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(list.name),
              subtitle: Text("${list.items.length} items"),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: _handleShowDialog,
              ),
            ],
          ),
          body: [
            PickElement(
              groupList: list,
            ),
            ShuffleElement(
              groupList: list,
            ),
            GroupElement(
              groupList: list,
            ),
            ManageElement(
              groupList: list,
            ),
          ].elementAt(index),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            selectedIconTheme: Theme.of(context).iconTheme,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedIconTheme: Theme.of(context).iconTheme,
            unselectedItemColor: Theme.of(context).colorScheme.onBackground,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: "Pick",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shuffle),
                label: "Shuffle",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.group),
                label: "Group",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.edit),
                label: "Manage",
              ),
            ],
            currentIndex: index,
            onTap: (int value) {
              setState(() {
                ref.read(listDetailProvider.notifier).reset();
                index = value;
              });
            },
          ),
        );
      },
      error: (error, stackTrace) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Center(
          child: Text(error.toString()),
        ),
      ),
      loading: () => Scaffold(
        appBar: AppBar(
          title: const Text('Loading'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
