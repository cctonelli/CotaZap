import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cota_zap/core/di/injection.dart';
import 'package:go_router/go_router.dart';
import 'package:cota_zap/features/auth/presentation/controllers/auth_controller.dart';
import 'package:cota_zap/core/network/supabase_service.dart';
import 'package:cota_zap/drift/database.dart';
import 'package:drift/drift.dart' hide Column;

class OnboardingRolePage extends ConsumerStatefulWidget {
  const OnboardingRolePage({super.key});

  @override
  ConsumerState<OnboardingRolePage> createState() => _OnboardingRolePageState();
}

class _OnboardingRolePageState extends ConsumerState<OnboardingRolePage> {
  bool _checkingRole = true;

  @override
  void initState() {
    super.initState();
    _checkUserRole();
  }

  Future<void> _checkUserRole() async {
    try {
      final user = ref.read(authControllerProvider).value;
      if (user == null) return;

      if (user.email == 'admin@cotazap.com.br') {
        _redirect('/admin-dashboard', UserRole.admin);
        return;
      }

      final profile = await SupabaseService.client
          .from('profiles')
          .select('role')
          .eq('id', user.id)
          .maybeSingle();

      if (profile != null && profile['role'] != null) {
        final String roleStr = profile['role'].toString().toLowerCase();
        final isBuyer = roleStr.contains('buyer');
        final isSupplier = roleStr.contains('supplier');

        // --- SISTEMA DE AUTO-SINCRONIZAÇÃO NA ENTRADA ---
        var contact = await ref.read(contactsDaoProvider).getMyProfile(user.id, email: user.email);
        
        if (contact == null) {
          debugPrint('🔍 Perfil não disponível localmente. Sincronizando antes de decidir...');
          final remoteData = await SupabaseService.client
              .from('app_contacts')
              .select()
              .eq('owner_id', user.id)
              .maybeSingle();

          if (remoteData != null) {
            debugPrint('✅ Perfil resgatado do Supabase! Preparando redirecionamento...');
            await ref.read(contactsDaoProvider).upsertContact(AppContactsCompanion(
              id: Value(remoteData['id']),
              tradeName: Value(remoteData['trade_name'] ?? ''),
              contactName: Value(remoteData['contact_name']),
              whatsapp: Value(remoteData['whatsapp']),
              email: Value(remoteData['email']),
              ownerId: Value(remoteData['owner_id']),
              isBuyer: Value(isBuyer),
              isSupplier: Value(isSupplier),
              isSynced: const Value(true),
            ));
            contact = await ref.read(contactsDaoProvider).getMyProfile(user.id, email: user.email);
          }
        }
        // ------------------------------------------------

        // Se for AMBOS, deixa ele escolher na tela (mesmo que esteja completo)
        if (isBuyer && isSupplier) {
          if (mounted) setState(() => _checkingRole = false);
          return;
        }

        // Se for só UM, verifica se está completo para auto-redirect
        if (isBuyer) {
          if (_isProfileComplete(contact, UserRole.buyer)) {
            _redirect('/buyer-dashboard', UserRole.buyer);
            return;
          }
        } else if (isSupplier) {
          if (_isProfileComplete(contact, UserRole.supplier)) {
            _redirect('/supplier-dashboard', UserRole.supplier);
            return;
          }
        }
        
        if (mounted) setState(() => _checkingRole = false);
      } else {
        if (mounted) setState(() => _checkingRole = false);
      }
    } catch (e) {
      if (mounted) setState(() => _checkingRole = false);
    }
  }

  bool _isProfileComplete(dynamic contact, UserRole role) {
    if (contact == null) return false;
    
    final hasTrade = (contact.tradeName as String).isNotEmpty && 
                     !contact.tradeName.contains('@'); // Evita e-mail como nome fantasia
    final hasWhatsApp = (contact.whatsapp as String?)?.isNotEmpty ?? false;
    
    if (role == UserRole.buyer) {
      return hasTrade && hasWhatsApp;
    } else {
      final hasContact = (contact.contactName as String?)?.isNotEmpty ?? false;
      return hasTrade && hasWhatsApp && hasContact;
    }
  }

  void _redirect(String path, UserRole role) {
    if (!mounted) return;
    ref.read(userRoleProvider.notifier).state = role;
    context.go(path);
  }

  @override
  Widget build(BuildContext context) {
    if (_checkingRole) {
      return const Scaffold(
        backgroundColor: Color(0xFF128C7E),
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }
    
    final currentUser = ref.watch(authControllerProvider).value;
    final isAdmin = currentUser?.email == 'admin@cotazap.com.br';

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF075E54), Color(0xFF128C7E)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 100,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.bolt,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'CotaZap',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Cotações Rápidas no WhatsApp',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                const SizedBox(height: 48),
                const Text(
                  'Escolha seu perfil para começar:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                
                if (!isAdmin) ...[
                  // Card Comprador
                  _RoleCard(
                    title: 'Sou Comprador',
                    subtitle: 'Quero cotar produtos rapidamente com meus fornecedores.',
                    icon: Icons.shopping_cart_checkout,
                    onTap: () async {
                      try {
                        debugPrint('🔵 Iniciando fluxo "Sou Comprador"...');
                        final user = ref.read(authControllerProvider).value ?? SupabaseService.client.auth.currentUser;
                        if (user == null) {
                          debugPrint('❌ Usuário não encontrado no Riverpod nem no Supabase');
                          context.go('/login');
                          return;
                        }
                        
                        ref.read(userRoleProvider.notifier).state = UserRole.buyer;
                        
                        // 1. Busca local (Passando e-mail para garantir)
                        var contact = await ref.read(contactsDaoProvider).getMyProfile(user.id, email: user.email);
                        
                        // 2. Busca remota se não achar local
                        if (contact == null) {
                          debugPrint('🔍 Perfil vazio localmente. Buscando no Supabase...');
                          final remoteData = await SupabaseService.client
                              .from('app_contacts')
                              .select()
                              .eq('owner_id', user.id)
                              .maybeSingle();

                          if (remoteData != null) {
                            debugPrint('✅ Dados encontrados no Supabase! Sincronizando...');
                            await ref.read(contactsDaoProvider).upsertContact(AppContactsCompanion(
                              id: Value(remoteData['id']),
                              tradeName: Value(remoteData['trade_name']),
                              contactName: Value(remoteData['contact_name']),
                              whatsapp: Value(remoteData['whatsapp']),
                              email: Value(remoteData['email']),
                              ownerId: Value(remoteData['owner_id']),
                              isBuyer: const Value(true),
                              isSynced: const Value(true),
                            ));
                            contact = await ref.read(contactsDaoProvider).getMyProfile(user.id);
                          }
                        }
                        
                        if (_isProfileComplete(contact, UserRole.buyer)) {
                          debugPrint('✅ Perfil completo, indo para Dashboard');
                          context.go('/buyer-dashboard');
                        } else {
                          debugPrint('⚠️ Perfil incompleto, indo para BuyerProfilePage');
                          context.go('/buyer-profile');
                        }
                      } catch (e) {
                        debugPrint('❌ Erro no clique Comprador: $e');
                        context.go('/buyer-profile'); // Vai para o perfil em caso de erro para garantir o fluxo
                      }
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Card Fornecedor
                  _RoleCard(
                    title: 'Sou Fornecedor',
                    subtitle: 'Quero me cadastrar na rede e oferecer produtos.',
                    icon: Icons.storefront,
                    onTap: () async {
                      try {
                        debugPrint('🟠 Iniciando fluxo "Sou Fornecedor"...');
                        final user = ref.read(authControllerProvider).value ?? SupabaseService.client.auth.currentUser;
                        if (user == null) {
                          context.go('/login');
                          return;
                        }
                        
                        ref.read(userRoleProvider.notifier).state = UserRole.supplier;
                        
                        // Busca local e remota igual ao comprador
                        var contact = await ref.read(contactsDaoProvider).getMyProfile(user.id, email: user.email);
                        if (contact == null) {
                          final remoteData = await SupabaseService.client
                              .from('app_contacts')
                              .select()
                              .eq('owner_id', user.id)
                              .maybeSingle();

                          if (remoteData != null) {
                            await ref.read(contactsDaoProvider).upsertContact(AppContactsCompanion(
                              id: Value(remoteData['id']),
                              tradeName: Value(remoteData['trade_name']),
                              contactName: Value(remoteData['contact_name']),
                              whatsapp: Value(remoteData['whatsapp']),
                              email: Value(remoteData['email']),
                              ownerId: Value(remoteData['owner_id']),
                              isSupplier: const Value(true),
                              isSynced: const Value(true),
                            ));
                            contact = await ref.read(contactsDaoProvider).getMyProfile(user.id);
                          }
                        }
                        
                        if (_isProfileComplete(contact, UserRole.supplier)) {
                          debugPrint('✅ Perfil completo, indo para Dashboard');
                          context.go('/supplier-dashboard');
                        } else {
                          debugPrint('⚠️ Perfil incompleto, indo para SupplierProfilePage');
                          context.go('/supplier-profile');
                        }
                      } catch (e) {
                        debugPrint('❌ Erro no clique Fornecedor: $e');
                        context.go('/supplier-profile');
                      }
                    },
                    secondary: true,
                  ),
                ],

                if (isAdmin) ...[
                  // Card Admin
                  _RoleCard(
                    title: 'Administrador',
                    subtitle: 'Acesso total ao gerenciamento do sistema.',
                    icon: Icons.admin_panel_settings,
                    onTap: () {
                      ref.read(userRoleProvider.notifier).state = UserRole.admin;
                      context.go('/admin-dashboard');
                    },
                    colorOverride: Colors.indigo,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final bool secondary;
  final Color? colorOverride;

  const _RoleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.secondary = false,
    this.colorOverride,
  });

  @override
  Widget build(BuildContext context) {
    final Color mainColor = colorOverride ?? (secondary ? Colors.orange : const Color(0xFF25D366));
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: mainColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: mainColor,
                size: 32,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
