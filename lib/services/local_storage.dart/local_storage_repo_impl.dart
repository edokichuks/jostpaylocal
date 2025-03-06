// Dart imports:
import 'dart:async';

// Package imports:
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jost_pay_wallet/services/local_storage.dart/local_storage_export.dart';
import 'package:provider/provider.dart';


// Project imports:

class LocalStorageRepoImpl implements LocalStorageRepo {
  LocalStorageRepoImpl(this.box);
  final Box box;
  @override
  Future<void> put(dynamic key, dynamic value) async {
    return box.put(key, value);
  }

  @override
  dynamic get<T>(String key) {
    return box.get(key);
  }

  @override
  dynamic getAt(int key) {
    return box.getAt(key);
  }

  @override
  Future<int> add(dynamic value) {
    return box.add(value);
  }

  @override
  Future<int> clear() {
    return box.clear();
  }

  @override
  Future<void> delete(dynamic value) {
    return box.delete(value);
  }

  @override
  Future<void> putAll(Map<String, dynamic> entries) async {
    return box.putAll(entries);
  }
}

//? final localStorage = context.read<LocalStorageRepo>(); // Read once

// OR
//? final localStorage = context.watch<LocalStorageRepo>(); // Listen for changes if applicable
