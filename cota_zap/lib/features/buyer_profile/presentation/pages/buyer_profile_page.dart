import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cota_zap/core/presentation/widgets/side_menu_drawer.dart';
import 'package:cota_zap/core/network/supabase_service.dart';
import 'package:cota_zap/core/utils/app_logger.dart';
import 'package:cota_zap/core/di/injection.dart';
import 'package:cota_zap/drift/database.dart';
import 'package:drift/drift.dart' as drift;

class BuyerProfilePage extends ConsumerStatefulWidget {
  const BuyerProfilePage({super.key});

  @override
  ConsumerState<BuyerProfilePage> createState() => _BuyerProfilePageState();
}

class _BuyerProfilePageState extends ConsumerState<BuyerProfilePage> {
  final _contactNameController = TextEditingController();
  final _nameController = TextEditingController(); // Nome Fantasia
  final _emailController = TextEditingController();
  final _whatsappController = TextEditingController();
  bool _isSupplierToo = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() => _isLoading = true);
    try {
      final user = SupabaseService.client.auth.currentUser;
      if (user == null) return;

      // 1. Perfil Mestre (Buscando apenas o ROLE, pois name/email estão em app_contacts)
      final profile = await SupabaseService.client
          .from('profiles')
          .select('role')
          .eq('id', user.id)
          .maybeSingle();

      if (profile != null) {
        setState(() {
          _nameController.text = profile['name'] ?? '';
          _emailController.text = profile['email'] ?? '';
          _isSupplierToo = profile['role'].toString().contains('supplier');
        });
      }

      // 2. Dados Detalhados
      final userId = ref.read(userIdProvider);
      if (userId == null) return;

      // 1. Tenta local (Atenção: Passando o e-mail para garantir o registro correto)
      var contact = await ref.read(contactsDaoProvider).getMyProfile(userId, email: user.email);
      
      // 2. Fallback Remoto (Segurança extra)
      if (contact == null) {
        debugPrint('🔍 Perfil não encontrado localmente na página de edição. Buscando remoto...');
        final remoteData = await SupabaseService.client
            .from('app_contacts')
            .select()
                .eq('owner_id', userId)
                .maybeSingle();

        if (remoteData != null) {
          await ref.read(contactsDaoProvider).upsertContact(AppContactsCompanion(
            id: drift.Value(remoteData['id']),
            tradeName: drift.Value(remoteData['trade_name'] ?? ''),
            contactName: drift.Value(remoteData['contact_name']),
            whatsapp: drift.Value(remoteData['whatsapp']),
            email: drift.Value(remoteData['email']),
            ownerId: drift.Value(remoteData['owner_id']),
            isBuyer: const drift.Value(true),
            isSynced: const drift.Value(true),
          ));
          contact = await ref.read(contactsDaoProvider).getMyProfile(userId, email: user.email);
        }
      }

      final contactData = contact;
      if (contactData != null && mounted) {
        setState(() {
          _nameController.text = contactData.tradeName;
          _contactNameController.text = contactData.contactName ?? '';
          _emailController.text = contactData.email ?? '';
          _whatsappController.text = (contactData.whatsapp ?? '').replaceFirst('+55 ', '');
        });
      }
    } catch (e) {
      AppLogger.error('Erro ao carregar perfil de comprador', error: e);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _contactNameController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _whatsappController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    setState(() => _isLoading = true);
    try {
      var userId = ref.read(userIdProvider);
      if (userId == null) {
        userId = SupabaseService.client.auth.currentUser?.id;
        if (userId != null) {
          ref.read(userIdProvider.notifier).state = userId;
        }
      }
      
      if (userId == null) throw Exception('Usuário não autenticado no Supabase. Faça login novamente.');
      
      final contactsDao = ref.read(contactsDaoProvider);

      // 1. Salva Localmente (Drift)
      await contactsDao.upsertContact(AppContactsCompanion(
        ownerId: drift.Value(userId),
        tradeName: drift.Value(_nameController.text),
        contactName: drift.Value(_contactNameController.text),
        email: drift.Value(_emailController.text),
        whatsapp: drift.Value('+55 ${_whatsappController.text}'),
        isBuyer: const drift.Value(true),
        isSupplier: drift.Value(_isSupplierToo || ref.read(userRoleProvider) == UserRole.supplier),
        active: const drift.Value(true),
        isSynced: const drift.Value(true),
      ));

      // 2. Salva no Supabase (Base Online)
      await SupabaseService.updateProfile(
        table: 'app_contacts',
        data: {
          'owner_id': userId,
          'trade_name': _nameController.text,
          'contact_name': _contactNameController.text,
          'email': _emailController.text,
          'whatsapp': '+55 ${_whatsappController.text}',
          'is_buyer': true,
          'is_supplier': _isSupplierToo || ref.read(userRoleProvider) == UserRole.supplier,
          'active': true,
        },
      );

      // 3. Atualiza a tabela mestra de perfis para o login híbrido
      await SupabaseService.client.from('profiles').update({
        'role': _isSupplierToo ? 'buyer,supplier' : 'buyer',
        'name': _nameController.text,
      }).eq('id', userId);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Perfil do Comprador atualizado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Erro ao salvar: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Perfil (Comprador)'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
      ),
      drawer: const SideMenuDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.grey.shade50],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 32),
              _buildForm(),
              const SizedBox(height: 40),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Center(
          child: Stack(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: const Color(0xFF128C7E).withOpacity(0.1),
                child: const Icon(Icons.person, size: 70, color: Color(0xFF128C7E)),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Color(0xFF128C7E),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.edit, size: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Center(
          child: Text(
            'Informações Pessoais',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        const Center(
          child: Text(
            'Mantenha seus dados atualizados para melhores cotações',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Card(
      elevation: 4,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildTextField(
              controller: _nameController,
              label: 'Nome Fantasia / Razão Social',
              icon: Icons.store,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _contactNameController,
              label: 'Nome do Contato',
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _emailController,
              label: 'E-mail',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _whatsappController,
              label: 'WhatsApp',
              icon: Icons.phone_android,
              prefixText: '+55 ',
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 12),
            SwitchListTile(
              title: const Text(
                'Também sou Fornecedor',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Ative para ofertar produtos na rede'),
              value: _isSupplierToo,
              activeColor: const Color(0xFF128C7E),
              onChanged: (val) => setState(() => _isSupplierToo = val),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? prefixText,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF128C7E)),
        prefixText: prefixText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF128C7E), width: 2),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _saveProfile,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF128C7E),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 2,
        ),
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                'SALVAR ALTERAÇÕES',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
      ),
    );
  }
}
