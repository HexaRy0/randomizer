import 'dart:math';

import 'package:randomizer/model/group_list.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'list_detail_provider.g.dart';

@riverpod
class ListDetail extends _$ListDetail {
  @override
  List<String> build() {
    return [];
  }

  void reset() {
    state = [];
  }

  void pickElement(GroupList groupList, int amount) {
    final items = [...groupList.items];
    final random = Random();

    final pickedItems = <String>[];

    for (var i = 0; i < amount; i++) {
      final item = items.removeAt(random.nextInt(items.length));

      pickedItems.add(item);
    }

    state = pickedItems;
  }

  void shuffleElements(GroupList groupList) {
    final items = [...groupList.items];
    final random = Random();

    final shuffledItems = <String>[];

    while (items.isNotEmpty) {
      final item = items.removeAt(random.nextInt(items.length));

      shuffledItems.add(item);
    }

    state = shuffledItems;
  }
}
