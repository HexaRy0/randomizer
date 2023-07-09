import 'package:isar/isar.dart';
import 'package:randomizer/model/group_list.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'async_group_list_provider.g.dart';

@riverpod
class AsyncGroupList extends _$AsyncGroupList {
  final isar = Isar.getInstance('randomizer');

  Future<List<GroupList>> _fetchGroupList() async {
    final list = await isar!.groupLists.where().findAll();

    return list;
  }

  @override
  FutureOr<List<GroupList>> build() async {
    return await _fetchGroupList();
  }

  Future<void> addGroupList(GroupList groupList) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await isar!.writeTxn(() async {
        await isar!.groupLists.put(groupList);
      });
      return await _fetchGroupList();
    });
  }

  Future<void> updateGroupList(GroupList groupList) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await isar!.writeTxn(() async {
        await isar!.groupLists.put(groupList);
      });
      return await _fetchGroupList();
    });
  }

  Future<void> deleteGroupList(GroupList groupList) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await isar!.writeTxn(() async {
        await isar!.groupLists.delete(groupList.id);
      });
      return await _fetchGroupList();
    });
  }
}
