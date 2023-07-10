import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:randomizer/model/group_list.dart';
import 'package:randomizer/screens/add_group_list/add_group_list.dart';

class ManageElement extends ConsumerStatefulWidget {
  const ManageElement({super.key, required this.groupList});

  final GroupList groupList;

  @override
  ConsumerState<ManageElement> createState() => _ManageElementState();
}

class _ManageElementState extends ConsumerState<ManageElement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AddGroupListScreen(
        groupList: widget.groupList,
        isChildElement: true,
        isEdit: true,
      ),
    );
  }
}
