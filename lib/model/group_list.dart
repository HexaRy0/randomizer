import 'package:isar/isar.dart';

part 'group_list.g.dart';

@Collection()
class GroupList {
  Id id = Isar.autoIncrement;

  String name;
  List<String> items;
  bool isGenerated;

  GroupList({
    required this.name,
    required this.items,
    this.isGenerated = false,
  });
}
