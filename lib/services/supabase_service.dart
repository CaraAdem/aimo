import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;
    final url = dotenv.env['SUPABASE_URL'];
    final anonKey = dotenv.env['SUPABASE_ANON_KEY'];
    if (url == null || anonKey == null) {
      throw Exception('Supabase credentials missing. Add SUPABASE_URL and SUPABASE_ANON_KEY to assets/env/.env');
    }
    await Supabase.initialize(url: url, anonKey: anonKey);
    _initialized = true;
  }

  SupabaseClient get client => Supabase.instance.client;

  // Auth API
  Future<AuthResponse> signUp({required String email, required String password, Map<String, dynamic>? data}) {
    return client.auth.signUp(email: email, password: password, data: data);
  }

  Future<AuthResponse> signIn({required String email, required String password}) {
    return client.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await client.auth.signOut();
  }

  Session? get currentSession => client.auth.currentSession;
  User? get currentUser => client.auth.currentUser;

  // Generic helpers (v2 API)
  Future<List<dynamic>> insert(String table, Map<String, dynamic> values) async {
    final data = await client.from(table).insert(values).select();
    return data as List<dynamic>;
  }

  Future<List<dynamic>> select(String table, {Map<String, dynamic>? eq, int? limit}) async {
    var query = client.from(table).select();
    eq?.forEach((key, value) {
      query = query.eq(key, value);
    });
    if (limit != null) query = query.limit(limit);
    final data = await query;
    return data as List<dynamic>;
  }

  Future<List<dynamic>> update(String table, Map<String, dynamic> values, {required Map<String, dynamic> match}) async {
    var query = client.from(table).update(values);
    match.forEach((key, value) {
      query = query.eq(key, value);
    });
    final data = await query.select();
    return data as List<dynamic>;
  }
}