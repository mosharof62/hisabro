import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product.dart';
import '../services/supabase_service.dart';

class ProductRepository {
  final String userId;

  ProductRepository(this.userId);

  Future<List<Product>> getAll() async {
    final data = await SupabaseService.fetchAll('products', userId);
    return data.map((json) => Product.fromJson(json)).toList();
  }

  Future<Product?> getById(String id) async {
    final data = await SupabaseService.fetchById('products', id);
    if (data == null) return null;
    return Product.fromJson(data);
  }

  Future<Product> create(Product product) async {
    final data = await SupabaseService.insert('products', product.toJson());
    return Product.fromJson(data);
  }

  Future<Product> update(Product product) async {
    final data = await SupabaseService.update(
      'products',
      product.id,
      product.toJson(),
    );
    return Product.fromJson(data);
  }

  Future<void> delete(String id) async {
    await SupabaseService.delete('products', id);
  }

  Future<List<Product>> getLowStock() async {
    final all = await getAll();
    return all.where((p) => p.isLowStock).toList();
  }

  Future<List<Product>> search(String query) async {
    final all = await getAll();
    final lowerQuery = query.toLowerCase();
    return all.where((p) => p.name.toLowerCase().contains(lowerQuery)).toList();
  }
}

// Riverpod Provider
final productRepositoryProvider = Provider.family<ProductRepository, String>((
  ref,
  userId,
) {
  return ProductRepository(userId);
});
