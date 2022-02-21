class Note {
  final String id = DateTime.now().toIso8601String();
  final DateTime createdTime = DateTime.now();
  String title;
  String description;
  bool isPinned;

  Note({
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
