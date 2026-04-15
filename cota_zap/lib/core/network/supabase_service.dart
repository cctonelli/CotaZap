import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cota_zap/core/config/app_config.dart';
import 'package:cota_zap/core/utils/app_logger.dart';

class SupabaseService {
  SupabaseService._internal();
  static final SupabaseService instance = SupabaseService._internal();

  static SupabaseClient? _client;

  static SupabaseClient get client {
    if (_client != null) return _client!;
    
    try {
      // Tenta recuperar do Singleton global do Supabase Flutter
      _client = Supabase.instance.client;
      return _client!;
    } catch (e) {
      AppLogger.error('Erro ao obter cliente Supabase', error: e, tag: 'Supabase');
      throw Exception('O cliente Supabase não foi inicializado corretamente.');
    }
  }

  static Future<void> initialize() async {
    try {
      try {
        _client = Supabase.instance.client;
        AppLogger.success('Supabase já inicializado.', tag: 'Supabase');
        return;
      } catch (_) {}

      final supabase = await Supabase.initialize(
        url: AppConfig.supabaseUrl,
        anonKey: AppConfig.supabaseAnonKey,
      );
      _client = supabase.client;
      AppLogger.success('Supabase inicializado do zero.', tag: 'Supabase');
    } catch (e) {
      AppLogger.error('Falha na inicialização do Supabase', error: e, tag: 'Supabase');
      rethrow;
    }
  }

  static Future<void> updateProfile({
    required String table,
    required dynamic data,
  }) async {
    try {
      AppLogger.info('Tentando upsert na tabela $table...', tag: 'Supabase');
      await client.from(table).upsert(data);
      AppLogger.success('Dados salvos com sucesso na tabela $table!', tag: 'Supabase');
    } catch (e) {
      AppLogger.error('Erro no upsert ($table)', error: e, tag: 'Supabase');
      rethrow;
    }
  }

  static Future<List<Map<String, dynamic>>> fetchTable({
    required String table,
    String select = '*',
    Map<String, dynamic>? filter,
  }) async {
    try {
      AppLogger.info('Buscando dados da tabela $table...', tag: 'Supabase');
      var query = client.from(table).select(select);
      
      if (filter != null) {
        filter.forEach((key, value) {
          if (key == 'or') {
            query = query.or(value as String);
          } else {
            query = query.eq(key, value);
          }
        });
      }
      
      final data = await query;
      return List<Map<String, dynamic>>.from(data as List);
    } catch (e) {
      AppLogger.error('Erro ao buscar dados ($table)', error: e, tag: 'Supabase');
      rethrow;
    }
  }
}
