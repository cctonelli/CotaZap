import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cota_zap/core/di/injection.dart';
import 'package:cota_zap/core/utils/app_logger.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService(ref));

class AuthService {
  final Ref _ref;
  final _supabase = Supabase.instance.client;

  AuthService(this._ref);

  User? get currentUser => _supabase.auth.currentUser;

  Future<void> signInWithEmail({required String email, required String password}) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user != null) {
        await _fetchProfile(response.user!.id);
      }
    } catch (e) {
      AppLogger.error('Login error', error: e, tag: 'Auth');
      rethrow;
    }
  }

  Future<void> signUpWithEmail({
    required String email, 
    required String password,
    required String name,
    required UserRole role,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': name},
      );
      
      if (response.user != null) {
        // Criar perfil inicial no Supabase
        await _supabase.from('profiles').insert({
          'id': response.user!.id,
          'full_name': name,
          'role': role.name,
          'plan_type': 'free',
        });
        
        _updateLocalState(response.user!.id, role, 'free');
      }
    } catch (e) {
      AppLogger.error('Signup error', error: e, tag: 'Auth');
      rethrow;
    }
  }

  Future<void> _fetchProfile(String userId) async {
    try {
      final data = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();
      
      final roleStr = data['role'] as String;
      final plan = data['plan_type'] as String;
      
      final role = UserRole.values.firstWhere(
        (e) => e.name == roleStr,
        orElse: () => UserRole.buyer,
      );
      
      _updateLocalState(userId, role, plan);
    } catch (e) {
      AppLogger.error('Fetch profile error', error: e, tag: 'Auth');
    }
  }

  void _updateLocalState(String userId, UserRole role, String plan) {
    _ref.read(userIdProvider.notifier).state = userId;
    _ref.read(userRoleProvider.notifier).state = role;
    _ref.read(planTypeProvider.notifier).state = plan;
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
    _ref.read(userIdProvider.notifier).state = null;
  }
}
