import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cota_zap/core/config/app_config.dart';
import 'package:flutter/foundation.dart';

class SupabaseService {
  SupabaseService._internal();
  static final SupabaseService instance = SupabaseService._internal();

  static SupabaseClient? _client;

  /// Getter para o cliente do Supabase, garantindo que foi inicializado
  SupabaseClient get client {
    if (_client == null) {
      try {
        _client = Supabase.instance.client;
      } catch (e) {
        throw 'SupabaseService: O cliente não foi inicializado corretamente. Garanta que o app foi reiniciado.';
      }
    }
    return _client!;
  }

  static Future<void> initialize() async {
    if (_client != null) return;
    try {
      final supabase = await Supabase.initialize(
        url: AppConfig.supabaseUrl,
        anonKey: AppConfig.supabaseAnonKey,
      );
      _client = supabase.client;
      if (kDebugMode) {
        print('✅ SupabaseService: Inicializado com sucesso.');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ SupabaseService: Falha ao inicializar: $e');
      }
      rethrow;
    }
  }

  /// Salva ou atualiza um perfil no Supabase
  Future<void> updateProfile({
    required String table, // 'buyers' ou 'suppliers'
    required Map<String, dynamic> data,
  }) async {
    try {
      await client.from(table).upsert(data);
    } catch (e) {
      if (kDebugMode) {
        print('❌ SupabaseService: Erro no upsert ($table): $e');
      }
      rethrow;
    }
  }
}
