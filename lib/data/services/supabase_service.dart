import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SupabaseService {
  static final SupabaseClient client = Supabase.instance.client;

  static Future<void> initialize(String url, String anonKey) async {
    await Supabase.initialize(url: url, anonKey: anonKey);
  }

  static Future<String?> getCurrentUserId() async {
    final user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  static Future<void> syncFirebaseAuth() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Get Firebase ID token and set it as Supabase auth token
      final idToken = await user.getIdToken();
      // Supabase will validate this JWT
      await client.auth.setSession(idToken!);
    }
  }

  // Generic CRUD operations
  static Future<List<Map<String, dynamic>>> fetchAll(
    String table,
    String userId,
  ) async {
    final response = await client
        .from(table)
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  static Future<Map<String, dynamic>?> fetchById(
    String table,
    String id,
  ) async {
    final response = await client
        .from(table)
        .select()
        .eq('id', id)
        .maybeSingle();

    return response;
  }

  static Future<Map<String, dynamic>> insert(
    String table,
    Map<String, dynamic> data,
  ) async {
    final response = await client.from(table).insert(data).select().single();

    return response;
  }

  static Future<Map<String, dynamic>> update(
    String table,
    String id,
    Map<String, dynamic> data,
  ) async {
    final response = await client
        .from(table)
        .update(data)
        .eq('id', id)
        .select()
        .single();

    return response;
  }

  static Future<void> delete(String table, String id) async {
    await client.from(table).delete().eq('id', id);
  }
}
