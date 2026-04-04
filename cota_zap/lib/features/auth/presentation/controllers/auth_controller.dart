import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cota_zap/core/di/injection.dart';
import 'package:cota_zap/core/network/supabase_service.dart';
import 'package:cota_zap/core/utils/app_logger.dart';

final authControllerProvider = StateNotifierProvider<AuthController, AsyncValue<User?>>((ref) {
  return AuthController(ref);
});

class AuthController extends StateNotifier<AsyncValue<User?>> {
  final Ref _ref;

  AuthController(this._ref) : super(const AsyncValue.data(null)) {
    // Escuta estado da sessão
    SupabaseService.client.auth.onAuthStateChange.listen((data) {
      final session = data.session;
      if (session != null) {
        state = AsyncValue.data(session.user);
        _ref.read(userIdProvider.notifier).state = session.user.id;
      } else {
        state = const AsyncValue.data(null);
        _ref.read(userIdProvider.notifier).state = null;
      }
    });
  }

  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final response = await SupabaseService.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      state = AsyncValue.data(response.user);
    } catch (e, stack) {
      AppLogger.error('Erro ao fazer login', error: e, tag: 'Auth');
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> signUp(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final response = await SupabaseService.client.auth.signUp(
        email: email,
        password: password,
      );
      state = AsyncValue.data(response.user);
    } catch (e, stack) {
      AppLogger.error('Erro ao cadastrar usuário', error: e, tag: 'Auth');
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> signOut() async {
    await SupabaseService.client.auth.signOut();
  }
}
