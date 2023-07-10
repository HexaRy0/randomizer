import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:randomizer/model/group_list.dart';
import 'package:randomizer/providers/async_group_list_provider.dart';
import 'package:randomizer/providers/selected_group_list_provider.dart';
import 'package:randomizer/widgets/edit_item_dialog.dart';

class AddGroupListScreen extends ConsumerStatefulWidget {
  const AddGroupListScreen({
    super.key,
    this.groupList,
    this.isChildElement = false,
    this.isEdit = false,
    this.isFromOtherScreen = false,
  });

  final GroupList? groupList;
  final bool isChildElement;
  final bool isEdit;
  final bool isFromOtherScreen;

  @override
  ConsumerState<AddGroupListScreen> createState() => _AddGroupListScreenState();
}

class _AddGroupListScreenState extends ConsumerState<AddGroupListScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final List<String> _items = [];

  void _handleSubmitButton() {
    if (_formKey.currentState!.saveAndValidate()) {
      final name = _formKey.currentState!.value['listName'];
      final items = _items;

      if (widget.isEdit) {
        final newGroupList = widget.groupList!;
        newGroupList.name = name;
        newGroupList.items = items;

        ref.read(asyncGroupListProvider.notifier).updateGroupList(newGroupList);

        if (widget.isChildElement) return;

        if (widget.isFromOtherScreen) {
          ref.read(selectedGroupListProvider.notifier).selectGroupList(newGroupList);

          Navigator.of(context).pop(newGroupList);
        } else {
          Navigator.of(context).pop();
        }
      } else {
        final newGroupList = GroupList(name: name, items: items);

        ref.read(asyncGroupListProvider.notifier).addGroupList(newGroupList);

        if (widget.isChildElement) return;

        if (widget.isFromOtherScreen) {
          ref.read(selectedGroupListProvider.notifier).selectGroupList(newGroupList);

          Navigator.of(context).pop(newGroupList);
        } else {
          Navigator.of(context).pop();
        }
      }
    }
  }

  void _handleShowDialog(int index) {
    showDialog(
      context: context,
      builder: (context) => EditItemDialog(
        item: _items[index],
        onEdit: (value) => setState(() => _items[index] = value),
      ),
    );
  }

  @override
  void initState() {
    if (widget.isEdit) {
      _items.addAll(widget.groupList!.items);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isChildElement
          ? null
          : AppBar(
              title: const Text("Add New List"),
              actions: [
                IconButton(
                  icon: const Icon(Icons.save),
                  onPressed: _handleSubmitButton,
                ),
              ],
            ),
      floatingActionButton: widget.isEdit
          ? FloatingActionButton.extended(
              label: const Text("Save Changes"),
              icon: const Icon(Icons.save),
              onPressed: _handleSubmitButton,
            )
          : FloatingActionButton.extended(
              label: const Text("Add List"),
              icon: const Icon(Icons.add),
              onPressed: _handleSubmitButton,
            ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                FormBuilderTextField(
                  name: 'listName',
                  initialValue: widget.isEdit ? widget.groupList!.name : '',
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
                          labelText: 'Add New Item',
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
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_items[index]),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => _handleShowDialog(index),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  setState(() {
                                    _items.removeAt(index);
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 72),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
