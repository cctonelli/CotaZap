import 'package:cota_zap/core/di/injection.dart';
import 'package:cota_zap/drift/database.dart';
import 'package:cota_zap/features/auth/domain/repositories/profile_repository.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingController extends StateNotifier<AsyncValue<void>> {
  final ProfileRepository _profileRepository;
  final Ref _ref;

  OnboardingController(this._profileRepository, this._ref) : super(const AsyncValue.data(null));

  Future<void> selectRole(UserRole role, {required String userId, required String email}) async {
    state = const AsyncValue.loading();
    try {
      final roleStr = role == UserRole.buyer ? 'buyer' : (role == UserRole.supplier ? 'supplier' : 'admin');
      
      // 1. Atualiza papel no perfil (Local + Cloud)
      await _profileRepository.updateProfileRole(userId, roleStr);
      
      // 2. Garante que existe um contato para o usuário
      final existingContact = await _profileRepository.getMyContact(userId);
      if (existingContact == null) {
        await _profileRepository.upsertMyContact(AppContactsCompanion(
          ownerId: Value(userId),
          email: Value(email),
          tradeName: Value(email.split('@')[0]), // Default temporário
          whatsapp: const Value(''),
          isBuyer: Value(role == UserRole.buyer),
          isSupplier: Value(role == UserRole.supplier),
          isSynced: const Value(false),
        ));
      } else {
        // Atualiza flags se necessário
        await _profileRepository.upsertMyContact(AppContactsCompanion(
          id: Value(existingContact.id),
          ownerId: Value(userId),
          isBuyer: Value(existingContact.isBuyer || role == UserRole.buyer),
          isSupplier: Value(existingContact.isSupplier || role == UserRole.supplier),
        ));
      }

      // 3. Atualiza estado global
      _ref.read(userRoleProvider.notifier).state = role;
      
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

final onboardingControllerProvider = StateNotifierProvider<OnboardingController, AsyncValue<void>>((ref) {
  return OnboardingController(ref.watch(profileRepositoryProvider), ref);
});
