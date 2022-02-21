import '/models/note.dart';

class Category {
  // add late if it's not working
  final String id = DateTime.now().toIso8601String();
  final DateTime createdTime = DateTime.now();
  String title;
  bool isPinned;
  Map<String, Note>? notes;

  Category({
    required this.title,
    required this.notes,
    this.isPinned = false,
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
    if (notes != null) {
      data['notes'] = notes;
    } else {
      data['notes'] = {};
    }
    return data;
  }
}
