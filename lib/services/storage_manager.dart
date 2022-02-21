import 'package:localstorage/localstorage.dart';

class StorageManager {
  final String storageName;
  final String itemName;
  late LocalStorage _storage;

  StorageManager({
    required this.storageName,
    required this.itemName,
  }) {
    _storage = LocalStorage(storageName);
  }

  Future<List<dynamic>> getItems() async {
    if (await _storage.ready) {
      return _storage.getItem(itemName).values.toList();
    }
    return [];
  }

  Future<Map> getItemById(String id) async {
    if (await _storage.ready) {
      return _storage.getItem(itemName)[id];
    }
    return {};
  }

  Future<void> newItem(dynamic object) async {
    if (await _storage.ready) {
      final items = _storage.getItem(itemName) ?? {};
      items.addAll({object.id: object.toJson()});
      _storage.setItem(itemName, items);
    }
  }

  Future<void> updateItem(dynamic object) async {
    if (await _storage.ready) {
      final tmp = _storage.getItem(itemName);
      tmp[object.id] = object.toJson();
      _storage.setItem(itemName, tmp);
    }
  }

  Future<void> deleteItem(String id) async {
    if (await _storage.ready) {
      final tmp = _storage.getItem(itemName);
      tmp.removeWhere((key, value) => key == id);
      _storage.setItem(itemName, tmp);
    }
  }
}
