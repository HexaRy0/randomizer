import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:randomizer/providers/async_group_list_provider.dart';
import 'package:randomizer/screens/list_detail/list_detail.dart';
import 'package:randomizer/static/route_name.dart';
import 'package:randomizer/static/strings.dart';

class ListRandomizerScreen extends ConsumerStatefulWidget {
  const ListRandomizerScreen({super.key});

  @override
  ConsumerState<ListRandomizerScreen> createState() => _ListRandomizerScreenState();
}

class _ListRandomizerScreenState extends ConsumerState<ListRandomizerScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool isSearch = false;

  @override
  Widget build(BuildContext context) {
    final groupLists = ref.watch(asyncGroupListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(StaticStrings.listRandomizer),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("New List"),
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(RouteName.addGroupList);
        },
      ),
      body: groupLists.when(
        skipLoadingOnRefresh: true,
        skipLoadingOnReload: true,
        data: (groupList) {
          var groupListData = isSearch
              ? groupList
                  .where(
                    (element) => element.name.toLowerCase().contains(
                          (_formKey.currentState!.value['search'] as String).toLowerCase(),
                        ),
                  )
                  .toList()
              : groupList;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormBuilder(
                  key: _formKey,
                  child: FormBuilderTextField(
                    name: 'search',
                    initialValue: "",
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: "Type to search list",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    onChanged: (value) {
                      _formKey.currentState!.save();
                      if (value!.isEmpty) {
                        setState(() {
                          isSearch = false;
                        });
                      } else {
                        setState(() {
                          isSearch = true;
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: Column(
                    children: [
                      ...groupListData.map(
                        (group) => ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ListDetailScreen(groupList: group),
                              ),
                            );
                          },
                          title: Text(group.name),
                          subtitle: Text(
                            group.items.join(", "),
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: const Icon(Icons.chevron_right),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) => const Center(
          child: Text('Error'),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
