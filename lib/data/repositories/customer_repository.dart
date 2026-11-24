import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/customer.dart';
import '../services/supabase_service.dart';

class CustomerRepository {
  final String userId;

  CustomerRepository(this.userId);

  Future<List<Customer>> getAll() async {
    final data = await SupabaseService.fetchAll('customers', userId);
    return data.map((json) => Customer.fromJson(json)).toList();
  }

  Future<Customer?> getById(String id) async {
    final data = await SupabaseService.fetchById('customers', id);
    if (data == null) return null;
    return Customer.fromJson(data);
  }

  Future<Customer> create(Customer customer) async {
    final data = await SupabaseService.insert('customers', customer.toJson());
    return Customer.fromJson(data);
  }

  Future<Customer> update(Customer customer) async {
    final data = await SupabaseService.update(
      'customers',
      customer.id,
      customer.toJson(),
    );
    return Customer.fromJson(data);
  }

  Future<void> delete(String id) async {
    await SupabaseService.delete('customers', id);
  }

  Future<List<Customer>> search(String query) async {
    final all = await getAll();
    final lowerQuery = query.toLowerCase();
    return all
        .where(
          (c) =>
              c.name.toLowerCase().contains(lowerQuery) ||
              (c.phone?.contains(query) ?? false) ||
              (c.email?.toLowerCase().contains(lowerQuery) ?? false),
        )
        .toList();
  }
}

// Riverpod Provider
final customerRepositoryProvider = Provider.family<CustomerRepository, String>((
  ref,
  userId,
) {
  return CustomerRepository(userId);
});
