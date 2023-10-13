import 'package:phoenix_selection/phoenix_selection.dart';

class BrnFilterEntity {
  String? key;
  late String name;
  String? defaultValue;
  late List<ItemEntity> children;

  BrnFilterEntity.fromJson(Map<String, dynamic> map) {
    key = map['key'] ?? '';
    name = map['title'] ?? '';
    defaultValue = map['defaultValue'] ?? '';
    children = []..addAll(
        (map['children'] as List? ?? []).map((o) => ItemEntity.fromJson(o)));
  }
}
