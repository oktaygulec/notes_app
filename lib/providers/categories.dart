import 'package:flutter/foundation.dart' show ChangeNotifier;

import '/models/category.dart';
import '/services/storage_manager.dart';

class Categories with ChangeNotifier {
  final StorageManager _storageManager =
      StorageManager(storageName: "notes", itemName: "categories");

  Map<String, Category> _items = {};

  Map<String, Category> get items {
    return Map<String, Category>.from(_items);
  }

  List<Category> get pinnedItems =>
      _items.values.where((e) => e.isPinned).toList();

  Future<void> getCategories() async {
    _items = await _storageManager.getItems() as Map<String, Category>;
    notifyListeners();
  }

  Future<void> newCategory(Category category) async {
    _items.addAll({category.id: category});
    await _storageManager.newItem(category);
    notifyListeners();
  }

  Future<void> updateCategory(Category category) async {
    _items[category.id] = category;
    await _storageManager.updateItem(category);
    notifyListeners();
  }

  Future<void> deleteCategory(Category category) async {
    _items.removeWhere((key, value) => key == category.id);
    await _storageManager.deleteItem(category.id);
    notifyListeners();
  }
}
