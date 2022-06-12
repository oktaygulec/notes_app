import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 1)
class Note {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final DateTime createdTime;
  @HiveField(2)
  String title;
  @HiveField(3)
  String description;
  @HiveField(4)
  bool isPinned;

  Note({
    required this.id,
    required this.createdTime,
    required this.title,
    required this.description,
    this.isPinned = false,
  });

  // fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   content = json['content'];
  //   createdTime = DateTime.parse(json['createdTime']);
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['createdTime'] = createdTime.toIso8601String();
    data['isPinned'] = isPinned;
    return data;
  }
}
