import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalStorageService {
  static const String productsBox = 'products';
  static const String customersBox = 'customers';
  static const String invoicesBox = 'invoices';
  static const String settingsBox = 'settings';
  static const String syncQueueBox = 'sync_queue';

  static Future<void> initialize() async {
    await Hive.initFlutter();
    await Hive.openBox(productsBox);
    await Hive.openBox(customersBox);
    await Hive.openBox(invoicesBox);
    await Hive.openBox(settingsBox);
    await Hive.openBox(syncQueueBox);
  }

  static Box getBox(String name) {
    return Hive.box(name);
  }

  // Products
  static Future<void> saveProduct(Map<String, dynamic> product) async {
    final box = Hive.box(productsBox);
    await box.put(product['id'], product);
  }

  static List<Map<String, dynamic>> getAllProducts() {
    final box = Hive.box(productsBox);
    return box.values.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  static Future<void> deleteProduct(String id) async {
    final box = Hive.box(productsBox);
    await box.delete(id);
  }

  // Customers
  static Future<void> saveCustomer(Map<String, dynamic> customer) async {
    final box = Hive.box(customersBox);
    await box.put(customer['id'], customer);
  }

  static List<Map<String, dynamic>> getAllCustomers() {
    final box = Hive.box(customersBox);
    return box.values.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  // Settings
  static Future<void> saveSetting(String key, dynamic value) async {
    final box = Hive.box(settingsBox);
    await box.put(key, value);
  }

  static dynamic getSetting(String key, {dynamic defaultValue}) {
    final box = Hive.box(settingsBox);
    return box.get(key, defaultValue: defaultValue);
  }

  // Sync Queue
  static Future<void> addToSyncQueue(Map<String, dynamic> operation) async {
    final box = Hive.box(syncQueueBox);
    await box.add(operation);
  }

  static List<Map<String, dynamic>> getSyncQueue() {
    final box = Hive.box(syncQueueBox);
    return box.values.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  static Future<void> clearSyncQueue() async {
    final box = Hive.box(syncQueueBox);
    await box.clear();
  }
}

final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});
