import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:notesapp/services/storage_manager.dart';

import '../models/note.dart';
import '/models/category.dart';

class Notes with ChangeNotifier {
  final StorageManager _storageManager =
      StorageManager(storageName: "notes", itemName: "categories");

  List<Note> getNotes(Category category) {
    return category.notes!.values.toList();
  }

  Note? getNoteById(String taskId, Category category) {
    return category.notes![taskId];
  }

  Future<void> newNote(Note note, Category category) async {
    category.notes!.addAll({note.id: note});
    await _storageManager.updateItem(category);
  }

  Future<void> updateNote(Note note, Category category) async {
    category.notes![note.id] = note;
    await _storageManager.updateItem(category);
  }

  Future<void> deleteNote(String taskId, Category category) async {
    category.notes!.removeWhere((key, value) => key == taskId);
    await _storageManager.updateItem(category);
  }
}
