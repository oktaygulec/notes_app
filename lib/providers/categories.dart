import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:hive_flutter/hive_flutter.dart';

import '/models/category.dart';
import '/models/note.dart';

class Categories with ChangeNotifier {
  Box<Category> box = Hive.box('categories');

  Map<dynamic, Category> _items = {};

  Map<dynamic, Category> get items {
    return Map<dynamic, Category>.from(_items);
  }

  void init() {
    _items = box.toMap();
  }

  List<Category> get pinnedCategories =>
      _items.values.where((e) => e.isPinned).toList();

  Future<void> newCategory(Category category) async {
    await box.put(category.id, category);
    notifyListeners();
  }

  Future<void> updateCategory(Category category) async {
    await box.put(category.id, category);
    notifyListeners();
  }

  Future<void> deleteCategory(Category category) async {
    await box.delete(category.id);
    notifyListeners();
  }

  Future<void> pinCategorySwitch(Category category) async {
    category.isPinned = !category.isPinned;
    await box.put(category.id, category);
    notifyListeners();
  }

  // ---------------- NOTES ------------------ //

  List<Note> getAllNotes() {
    final categories = items.values.toList();
    final allNotesList = categories.map((e) {
      if (e.notes != null) {
        return e.notes!.values.toList();
      }
    }).toList();

    List<Note> allNotes = [];
    if (allNotesList.isNotEmpty) {
      for (var notesList in allNotesList) {
        if (notesList != null) {
          for (var note in notesList) {
            allNotes.insert(0, note);
          }
        }
      }
    }
    allNotes.sort(
      (a, b) => b.createdTime.compareTo(a.createdTime),
    );

    return allNotes;
  }

  List<Note> getPinnedNotes() {
    final categories = items.values.toList();
    final allPinnedNotesList = categories.map((e) {
      if (e.notes != null) {
        return e.notes!.values.where((e) => e.isPinned).toList();
      }
    }).toList();

    List<Note> pinnedNotes = [];

    for (var pinnedNotesList in allPinnedNotesList) {
      if (pinnedNotesList != null) {
        for (var note in pinnedNotesList) {
          pinnedNotes.insert(0, note);
        }
      }
    }

    return pinnedNotes;
  }

  Future<void> newNote(Note note, Category category) async {
    category.notes ??= {};
    category.notes!.addAll({note.id: note});
    await box.put(category.id, category);
    notifyListeners();
  }

  Future<void> updateNote(Note note) async {
    Category category = items.values
        .firstWhere((element) => element.notes!.containsKey(note.id));
    category.notes![note.id] = note;
    await box.put(category.id, category);
    notifyListeners();
  }

  Future<void> deleteNote(Note note) async {
    Category category = items.values
        .firstWhere((element) => element.notes!.containsKey(note.id));
    category.notes!.remove(note.id);
    await box.put(category.id, category);
    notifyListeners();
  }

  Future<void> pinNoteSwitch(Note note) async {
    Category category = items.values
        .firstWhere((element) => element.notes!.containsKey(note.id));
    category.notes![note.id]!.isPinned = !category.notes![note.id]!.isPinned;
    await box.put(category.id, category);
    notifyListeners();
  }
}
