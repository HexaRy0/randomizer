import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:randomizer/model/group_list.dart';
import 'package:randomizer/providers/async_group_list_provider.dart';
import 'package:randomizer/providers/selected_group_list_provider.dart';

class AddGroupListScreen extends ConsumerStatefulWidget {
  const AddGroupListScreen({super.key, this.isFromOtherScreen = false});

  final bool isFromOtherScreen;

  @override
  ConsumerState<AddGroupListScreen> createState() => _AddGroupListScreenState();
}

class _AddGroupListScreenState extends ConsumerState<AddGroupListScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final List<String> _items = [];

  void _handleAddButton() {
    if (_formKey.currentState!.saveAndValidate()) {
      final name = _formKey.currentState!.value['listName'];
      final items = _items;
      final newGroupList = GroupList(name: name, items: items);

      ref.read(asyncGroupListProvider.notifier).addGroupList(newGroupList);

      if (widget.isFromOtherScreen) {
        ref.read(selectedGroupListProvider.notifier).selectGroupList(newGroupList);

        Navigator.of(context).pop(newGroupList);
      } else {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New List"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _handleAddButton,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Add List"),
        icon: const Icon(Icons.add),
        onPressed: _handleAddButton,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                FormBuilderTextField(
                  name: 'listName',
                  decoration: const InputDecoration(
                    labelText: 'List Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: FormBuilderTextField(
                        name: 'item',
                        decoration: const InputDecoration(
                          labelText: 'New Item',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        child: const Text(
                          'Add Item',
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.saveAndValidate()) {
                            if (_formKey.currentState!.value['item'] == null ||
                                _formKey.currentState!.value['item'] == '') {
                              return;
                            }
                            setState(() {
                              _formKey.currentState!.save();
                              _items.add(_formKey.currentState!.value['item']);
                              _formKey.currentState!.fields['item']!.reset();
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ListView.separated(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: _items.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_items[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            _items.removeAt(index);
                          });
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
