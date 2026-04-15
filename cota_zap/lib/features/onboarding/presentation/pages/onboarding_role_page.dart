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
  bool _canBeBuyer = false;
  bool _canBeSupplier = false;

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

      // 1. Busca o seu perfil específico pelo E-MAIL
      final profileContact = await ref.read(contactsDaoProvider).getMyProfile(user.id, email: user.email);

      if (profileContact != null) {
        _canBeBuyer = profileContact.isBuyer;
        _canBeSupplier = profileContact.isSupplier;

        // Se o registro existe mas não tem nenhum papel marcado, libera ambos
        if (!_canBeBuyer && !_canBeSupplier) {
          _canBeBuyer = true;
          _canBeSupplier = true;
        }

        if (mounted) setState(() => _checkingRole = false);

        if (_canBeBuyer && _canBeSupplier) return;

        if (_canBeBuyer) {
          _handleBuyerClick();
          return;
        } else if (_canBeSupplier) {
          _handleSupplierClick();
          return;
        }
      } else {
        // 2. Fallback para tabela profiles
        final profile = await SupabaseService.client
            .from('profiles')
            .select('role')
            .eq('id', user.id)
            .maybeSingle();

        if (profile != null && profile['role'] != null) {
          final String roleStr = profile['role'].toString().toLowerCase();
          _canBeBuyer = roleStr.contains('buyer');
          _canBeSupplier = roleStr.contains('supplier');
          
          if (mounted) setState(() => _checkingRole = false);

          if (_canBeBuyer && _canBeSupplier) return;
          if (_canBeBuyer) { _handleBuyerClick(); return; }
          if (_canBeSupplier) { _handleSupplierClick(); return; }
        } else {
          // 3. NOVO USUÁRIO: Libera as duas opções
          _canBeBuyer = true;
          _canBeSupplier = true;
        }
      }
      
      if (mounted) setState(() => _checkingRole = false);
    } catch (e) {
      if (mounted) setState(() => _checkingRole = false);
      _canBeBuyer = true;
      _canBeSupplier = true;
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

  Future<void> _handleBuyerClick() async {
    try {
      debugPrint('🔵 Iniciando fluxo "Sou Comprador"...');
      final user = ref.read(authControllerProvider).value ?? SupabaseService.client.auth.currentUser;
      if (user == null) {
        context.go('/login');
        return;
      }
      
      ref.read(userRoleProvider.notifier).state = UserRole.buyer;
      
      var contact = await ref.read(contactsDaoProvider).getMyProfile(user.id, email: user.email, isBuyer: true);
      
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
            isBuyer: const Value(true),
            isSynced: const Value(true),
          ));
          contact = await ref.read(contactsDaoProvider).getMyProfile(user.id);
        }
      }
      
      if (_isProfileComplete(contact, UserRole.buyer)) {
        context.go('/buyer-dashboard');
      } else {
        context.go('/buyer-profile');
      }
    } catch (e) {
      context.go('/buyer-profile');
    }
  }

  Future<void> _handleSupplierClick() async {
    try {
      debugPrint('🟠 Iniciando fluxo "Sou Fornecedor"...');
      final user = ref.read(authControllerProvider).value ?? SupabaseService.client.auth.currentUser;
      if (user == null) {
        context.go('/login');
        return;
      }
      
      ref.read(userRoleProvider.notifier).state = UserRole.supplier;
      
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
        context.go('/supplier-dashboard');
      } else {
        context.go('/supplier-profile');
      }
    } catch (e) {
      context.go('/supplier-profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_checkingRole) {
      return const Scaffold(
        backgroundColor: Color(0xFF128C7E),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Colors.white),
              SizedBox(height: 16),
              Text('Preparando seu ambiente...', style: TextStyle(color: Colors.white70)),
            ],
          ),
        ),
      );
    }
    
    final currentUser = ref.watch(authControllerProvider).value;
    final isAdmin = currentUser?.email == 'admin@cotazap.com.br';
    final isHybrid = _canBeBuyer && _canBeSupplier;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF075E54), Color(0xFF128C7E)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 100,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.bolt, size: 80, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'CotaZap',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Cotações Rápidas no WhatsApp',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  const SizedBox(height: 48),
                  Text(
                    isHybrid ? 'Identificamos que você possui dois perfis ativos.' : 'Escolha seu perfil para começar:',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  if (isHybrid) ...[
                    const SizedBox(height: 8),
                    const Text('Como deseja acessar agora?', style: TextStyle(color: Colors.white70)),
                  ],
                  const SizedBox(height: 32),
                  
                  if (!isAdmin) ...[
                    if (_canBeBuyer)
                      _RoleCard(
                        title: 'Sou Comprador',
                        subtitle: 'Quero cotar produtos rapidamente com meus fornecedores.',
                        icon: Icons.shopping_cart_checkout,
                        onTap: _handleBuyerClick,
                      ),
                    
                    if (_canBeBuyer && _canBeSupplier) const SizedBox(height: 20),
                    
                    if (_canBeSupplier)
                      _RoleCard(
                        title: 'Sou Fornecedor',
                        subtitle: 'Quero me cadastrar na rede e oferecer produtos.',
                        icon: Icons.storefront,
                        onTap: _handleSupplierClick,
                        secondary: true,
                      ),
                  ],

                  if (isAdmin) ...[
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
