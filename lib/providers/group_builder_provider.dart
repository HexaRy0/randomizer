import 'dart:math';

import 'package:randomizer/model/group_list.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'group_builder_provider.g.dart';

@riverpod
class GroupBuilder extends _$GroupBuilder {
  @override
  List<GroupList> build() {
    return [];
  }

  void generateGroupList(GroupList groupList, int amount) {
    final random = Random();
    final groupListItems = [...groupList.items];

    final List<GroupList> generatedGroupList = [];

    for (var i = 0; i < amount; i++) {
      generatedGroupList.add(
        GroupList(
          name: "Group ${i + 1}",
          items: [],
          isGenerated: true,
        ),
      );
    }

    while (groupListItems.isNotEmpty) {
      for (var i = 0; i < generatedGroupList.length; i++) {
        if (groupListItems.isEmpty) break;
        final groupList = generatedGroupList[i];
        final randomIndex = random.nextInt(groupListItems.length);
        final randomItem = groupListItems.removeAt(randomIndex);

        groupList.items.add(randomItem);
      }
    }

    state = generatedGroupList;
  }
}
