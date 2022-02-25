import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/note.dart';
import '/models/category.dart';
import '/providers/categories.dart';
import '/services/storage_manager.dart';

class Notes with ChangeNotifier {
  final StorageManager _storageManager =
      StorageManager(storageName: "notes", itemName: "categories");

  List<Note> getNotesByCategory(Category category) {
    return category.notes!.values.toList();
  }

  List<Note> getAllNotes(BuildContext context) {
    final category =
        Provider.of<Categories>(context, listen: false).items.values.toList();
    final allNotesList = category.map((e) => e.notes!.values.toList()).toList();

    List<Note> allNotes = [];

    for (var notesList in allNotesList) {
      for (var note in notesList) {
        allNotes.add(note);
      }
    }

    return allNotes;
  }

  List<Note> getPinnedNotes(BuildContext context) {
    final category =
        Provider.of<Categories>(context, listen: false).items.values.toList();
    final allPinnedNotesList = category
        .map((e) => e.notes!.values.where((e) => e.isPinned).toList())
        .toList();

    List<Note> pinnedNotes = [];

    for (var pinnedNotesList in allPinnedNotesList) {
      for (var note in pinnedNotesList) {
        pinnedNotes.add(note);
      }
    }

    return pinnedNotes;
  }

  Future<void> newNote(Note note, BuildContext context) async {
    final category =
        Provider.of<Categories>(context, listen: false).items[note.categoryId];
    if (category!.notes == null) {
      category.notes = {};
    }
    category.notes!.addAll({note.id: note});
    await _storageManager.updateItem(category);
    notifyListeners();
  }

  Future<void> updateNote(Note note, BuildContext context) async {
    final category =
        Provider.of<Categories>(context, listen: false).items[note.categoryId];
    category!.notes![note.id] = note;
    await _storageManager.updateItem(category);
    notifyListeners();
  }

  Future<void> deleteNote(Note note, BuildContext context) async {
    final category =
        Provider.of<Categories>(context, listen: false).items[note.categoryId];
    category!.notes!.removeWhere((key, value) => key == note.id);
    await _storageManager.updateItem(category);
    notifyListeners();
  }
}
