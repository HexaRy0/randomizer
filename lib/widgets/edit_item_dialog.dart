import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class EditItemDialog extends StatefulWidget {
  const EditItemDialog({super.key, required this.item, required this.onEdit});

  final String item;
  final void Function(String value) onEdit;

  @override
  State<EditItemDialog> createState() => _EditItemDialogState();
}

class _EditItemDialogState extends State<EditItemDialog> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit Item"),
      content: FormBuilder(
        key: _formKey,
        child: FormBuilderTextField(
          name: 'itemName',
          initialValue: widget.item,
          decoration: const InputDecoration(
            labelText: 'Item Name',
            border: OutlineInputBorder(),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.saveAndValidate()) {
              final itemName = _formKey.currentState!.value['itemName'];

              widget.onEdit(itemName);

              Navigator.of(context).pop();
            }
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
