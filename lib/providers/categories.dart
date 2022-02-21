import 'package:flutter/foundation.dart' show ChangeNotifier;

import '/models/category.dart';
import '/services/storage_manager.dart';

class Categories with ChangeNotifier {
  final StorageManager _storageManager =
      StorageManager(storageName: "notes", itemName: "categories");

  List<Category> _items = [];

  List<Category> get items {
    return [..._items];
  }

  Future<List<Category>> getCategories() async {
    _items = await _storageManager.getItems() as List<Category>;
    notifyListeners();
    return _items;
  }

  Future<void> newCategory(Category category) async {
    _items.add(category);
    await _storageManager.newItem(category);
    notifyListeners();
  }
}
