import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../services/supabase_service.dart';
import '../services/local_storage_service.dart';

class SyncService {
  final SupabaseService _supabase = SupabaseService();
  bool _isSyncing = false;

  bool get isSyncing => _isSyncing;

  Future<bool> isOnline() async {
    final connectivity = await Connectivity().checkConnectivity();
    return connectivity != ConnectivityResult.none;
  }

  Future<void> syncAll(String userId) async {
    if (_isSyncing) return;
    _isSyncing = true;

    try {
      // Sync products
      await _syncProducts(userId);

      // Sync customers
      await _syncCustomers(userId);

      // Sync invoices
      await _syncInvoices(userId);

      // Sync expenses
      await _syncExpenses(userId);

      // Process sync queue
      await _processSyncQueue();
    } finally {
      _isSyncing = false;
    }
  }

  Future<void> _syncProducts(String userId) async {
    try {
      final remoteProducts = await SupabaseService.fetchAll('products', userId);

      // Update local storage
      for (final product in remoteProducts) {
        await LocalStorageService.saveProduct(product);
      }
    } catch (e) {
      // Queue for later sync
      await LocalStorageService.addToSyncQueue({
        'type': 'sync_products',
        'user_id': userId,
        'timestamp': DateTime.now().toIso8601String(),
      });
    }
  }

  Future<void> _syncCustomers(String userId) async {
    try {
      final remoteCustomers = await SupabaseService.fetchAll(
        'customers',
        userId,
      );

      for (final customer in remoteCustomers) {
        await LocalStorageService.saveCustomer(customer);
      }
    } catch (e) {
      await LocalStorageService.addToSyncQueue({
        'type': 'sync_customers',
        'user_id': userId,
        'timestamp': DateTime.now().toIso8601String(),
      });
    }
  }

  Future<void> _syncInvoices(String userId) async {
    try {
      final remoteInvoices = await SupabaseService.fetchAll('invoices', userId);

      for (final invoice in remoteInvoices) {
        await LocalStorageService.saveProduct(
          invoice,
        ); // Using products box for simplicity
      }
    } catch (e) {
      await LocalStorageService.addToSyncQueue({
        'type': 'sync_invoices',
        'user_id': userId,
        'timestamp': DateTime.now().toIso8601String(),
      });
    }
  }

  Future<void> _syncExpenses(String userId) async {
    try {
      final remoteExpenses = await SupabaseService.fetchAll('expenses', userId);

      for (final expense in remoteExpenses) {
        // Save to local storage
      }
    } catch (e) {
      await LocalStorageService.addToSyncQueue({
        'type': 'sync_expenses',
        'user_id': userId,
        'timestamp': DateTime.now().toIso8601String(),
      });
    }
  }

  Future<void> _processSyncQueue() async {
    final queue = LocalStorageService.getSyncQueue();

    for (final operation in queue) {
      try {
        // Process each queued operation
        // TODO: Implement based on operation type
      } catch (e) {
        // Keep in queue for retry
        continue;
      }
    }

    // Clear successfully processed items
    await LocalStorageService.clearSyncQueue();
  }
}

final syncServiceProvider = Provider<SyncService>((ref) => SyncService());

final syncStatusProvider = StateProvider<SyncStatus>((ref) => SyncStatus.idle);

enum SyncStatus { idle, syncing, success, error }
