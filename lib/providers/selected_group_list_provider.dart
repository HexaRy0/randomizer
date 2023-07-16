import 'package:randomizer/model/group_list.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_group_list_provider.g.dart';

@riverpod
class SelectedGroupList extends _$SelectedGroupList {
  @override
  GroupList? build() {
    return null;
  }

  void selectGroupList(GroupList? groupList) {
    state = groupList;
  }

  void unselectGroupList() {
    state = null;
  }
}
