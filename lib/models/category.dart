import 'package:hive/hive.dart';

import '/models/note.dart';

part 'category.g.dart';

@HiveType(typeId: 2)
class Category {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final DateTime createdTime;
  @HiveField(2)
  String title;
  @HiveField(3)
  bool isPinned;
  @HiveField(4)
  Map<String, Note>? notes;

  Category({
    required this.id,
    required this.createdTime,
    required this.title,
    this.isPinned = false,
    this.notes,
  });

  // Category.fromJson(Map json) {
  //   id = json['id'];
  //   name = json['name'];
  //   createdTime = DateTime.parse(json['createdTime']);
  //   if (json['tasks'] != null) {
  //     notes = <String, Note>{};
  //     json['notes'].forEach((v) {
  //       v.fromJson();
  //       tasks.addAll({v.id: v});
  //     });
  //   }
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['createdTime'] = createdTime.toIso8601String();
    data['isPinned'] = isPinned;
    // data['notes'] = notes ?? {};
    Map<String, Map<String, dynamic>> _notes = {};

    if (notes != null) {
      for (var item in notes!.values) {
        _notes.addAll({item.id: item.toJson()});
      }
    }

    data['notes'] = _notes;

    return data;
  }
}
