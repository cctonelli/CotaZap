import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cota_zap/core/presentation/widgets/side_menu_drawer.dart';
import 'package:cota_zap/core/network/supabase_service.dart';
import 'package:cota_zap/core/utils/app_logger.dart';
import 'package:cota_zap/core/di/injection.dart';
import 'package:cota_zap/drift/database.dart';
import 'package:drift/drift.dart' as drift;
import 'package:cota_zap/core/services/cnpj_service.dart';

class SupplierProfilePage extends ConsumerStatefulWidget {
  const SupplierProfilePage({super.key});

  @override
  ConsumerState<SupplierProfilePage> createState() => _SupplierProfilePageState();
}

class _SupplierProfilePageState extends ConsumerState<SupplierProfilePage> {
  // Controladores detalhados para paridade com o cadastro de compradores
  final _cnpjController = TextEditingController();
  final _tradeNameController = TextEditingController(); // Nome Fantasia / Razão Social
  final _contactNameController = TextEditingController();
  final _whatsappController = TextEditingController();
  final _emailController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _neighborhoodController = TextEditingController();
  final _addressController = TextEditingController();
  final _complementController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  
  bool _isLoading = false;
  bool _isSearchingCnpj = false;
  bool _isBuyerToo = false;
  int? _contactId; // ID real da tabela app_contacts (BigInt no Supabase)

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
      
      final userId = ref.read(userIdProvider) ?? user.id;

      // 1. Papel (Híbrido) - Isolado
      try {
        final profile = await SupabaseService.client
            .from('profiles')
            .select('role')
            .eq('id', userId)
            .maybeSingle()
            .timeout(const Duration(seconds: 5));

        if (profile != null && mounted) {
          setState(() => _isBuyerToo = profile['role'].toString().contains('buyer'));
        }
      } catch (e) {
        debugPrint('⚠️ Perfil mestre inacessível: $e');
      }

      // 2. Dados Detalhados (Fornecedor)
      var contact = await ref.read(contactsDaoProvider).getMyProfile(userId, email: user.email, isSupplier: true);

      if (contact == null) {
        debugPrint('🔍 Buscando dados de fornecedor no Supabase...');
        try {
          final remoteData = await SupabaseService.client
              .from('app_contacts')
              .select()
              .eq('owner_id', userId)
              .eq('is_supplier', true)
              .maybeSingle()
              .timeout(const Duration(seconds: 10));

          if (remoteData != null) {
            await ref.read(contactsDaoProvider).upsertContact(AppContactsCompanion(
              id: drift.Value(remoteData['id']),
              tradeName: drift.Value(remoteData['trade_name'] ?? ''),
              cnpjCpf: drift.Value(remoteData['cnpj_cpf']),
              contactName: drift.Value(remoteData['contact_name']),
              whatsapp: drift.Value(remoteData['whatsapp']),
              email: drift.Value(remoteData['email']),
              ownerId: drift.Value(remoteData['owner_id']),
              isSupplier: const drift.Value(true),
              isSynced: const drift.Value(true),
            ));
            contact = await ref.read(contactsDaoProvider).getMyProfile(userId, isSupplier: true);
          }
        } catch (e) {
          debugPrint('❌ Erro ao baixar dados de fornecedor: $e');
        }
      }

      final contactData = contact;
      if (contactData != null && mounted) {
        setState(() {
          _contactId = contactData.id;
          _cnpjController.text = contactData.cnpjCpf ?? '';
          _tradeNameController.text = contactData.tradeName;
          _contactNameController.text = contactData.contactName ?? '';
          
          String phone = contactData.whatsapp ?? '';
          if (phone.startsWith('+55 ')) phone = phone.replaceFirst('+55 ', '');
          _whatsappController.text = phone;
          
          _emailController.text = contactData.email ?? user.email ?? '';
          _zipCodeController.text = contactData.zipCode ?? '';
          _neighborhoodController.text = contactData.neighborhood ?? '';
          _addressController.text = contactData.address ?? '';
          _complementController.text = contactData.complement ?? '';
          _cityController.text = contactData.city ?? '';
          _stateController.text = contactData.state ?? '';
        });
      } else if (mounted) {
        _emailController.text = user.email ?? '';
      }
    } catch (e) {
      AppLogger.error('Erro ao carregar perfil de fornecedor', error: e);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _cnpjController.dispose();
    _tradeNameController.dispose();
    _contactNameController.dispose();
    _whatsappController.dispose();
    _emailController.dispose();
    _zipCodeController.dispose();
    _neighborhoodController.dispose();
    _addressController.dispose();
    _complementController.dispose();
    _cityController.dispose();
    _stateController.dispose();
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

      if (userId == null) throw Exception('Usuário não autenticado.');


      final contactsDao = ref.read(contactsDaoProvider);

      // 1. Salva Localmente (Drift)
      await contactsDao.upsertContact(AppContactsCompanion(
        ownerId: drift.Value(userId),
        tradeName: drift.Value(_tradeNameController.text),
        cnpjCpf: drift.Value(_cnpjController.text),
        contactName: drift.Value(_contactNameController.text),
        whatsapp: drift.Value('+55 ${_whatsappController.text}'),
        email: drift.Value(_emailController.text),
        zipCode: drift.Value(_zipCodeController.text),
        neighborhood: drift.Value(_neighborhoodController.text),
        address: drift.Value(_addressController.text),
        complement: drift.Value(_complementController.text),
        city: drift.Value(_cityController.text),
        state: drift.Value(_stateController.text),
        isBuyer: drift.Value(_isBuyerToo),
        isSupplier: const drift.Value(true),
        active: const drift.Value(true),
        isRedeCotazap: const drift.Value(true),
        isSynced: const drift.Value(true),
      ));

      // 2. Salva no Supabase (Base Online)
      final Map<String, dynamic> supabaseData = {
        'owner_id': userId,
        'trade_name': _tradeNameController.text,
        'cnpj_cpf': _cnpjController.text,
        'contact_name': _contactNameController.text,
        'whatsapp': '+55 ${_whatsappController.text}',
        'email': _emailController.text,
        'zip_code': _zipCodeController.text,
        'neighborhood': _neighborhoodController.text,
        'address': _addressController.text,
        'complement': _complementController.text,
        'city': _cityController.text,
        'state': _stateController.text,
        'is_buyer': _isBuyerToo,
        'is_supplier': true,
        'active': true,
      };

      if (_contactId != null) {
        supabaseData['id'] = _contactId;
      }

      final response = await SupabaseService.client
          .from('app_contacts')
          .upsert(supabaseData)
          .select('id')
          .single();
      
      if (response != null && response['id'] != null) {
        _contactId = response['id'] as int;
      }

      // 3. Atualiza a tabela mestra de perfis para habilitar o redirecionamento híbrido
      await SupabaseService.client.from('profiles').update({
        'role': _isBuyerToo ? 'buyer,supplier' : 'supplier',
      }).eq('id', userId);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Perfil sincronizado com Supabase!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ Erro ao salvar: ${e.toString()}')),
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
        title: const Text('Meu Perfil de Fornecedor'),
        centerTitle: true,
      ),
      drawer: const SideMenuDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.orange,
              child: Icon(Icons.storefront, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text(
              'Configurações da Rede CotaZap',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Chip(
              label: Text('Fornecedor Verificado'),
              backgroundColor: Colors.greenAccent,
            ),
            const SizedBox(height: 32),
            
            const SizedBox(height: 32),
            
            // Formulário Completo
            Row(
              children: [
                Expanded(
                  child: _buildSheetTextField(
                    controller: _cnpjController, 
                    label: 'CNPJ / CPF', 
                    icon: Icons.badge_outlined,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 8),
                _isSearchingCnpj 
                  ? const CircularProgressIndicator()
                  : IconButton.filled(
                      onPressed: _onSearchCnpj, 
                      icon: const Icon(Icons.download),
                      style: IconButton.styleFrom(backgroundColor: Colors.orange),
                    ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSheetTextField(
              controller: _tradeNameController, 
              label: 'Nome Fantasia / Razão Social', 
              icon: Icons.store,
            ),
            const SizedBox(height: 16),
            _buildSheetTextField(controller: _contactNameController, label: 'Nome do Contato', icon: Icons.person_outline),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildSheetTextField(
                    controller: _whatsappController, 
                    label: 'WhatsApp', 
                    icon: Icons.phone_android, 
                    prefixText: '+55 ',
                    keyboardType: TextInputType.phone,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildSheetTextField(
                    controller: _emailController, 
                    label: 'E-mail', 
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                 Expanded(child: _buildSheetTextField(controller: _zipCodeController, label: 'CEP', icon: Icons.pin_drop_outlined, keyboardType: TextInputType.number)),
                 const SizedBox(width: 8),
                 Expanded(child: _buildSheetTextField(controller: _neighborhoodController, label: 'Bairro', icon: Icons.maps_home_work_outlined)),
              ],
            ),
            const SizedBox(height: 16),
            _buildSheetTextField(controller: _addressController, label: 'Logradouro e Número', icon: Icons.location_on_outlined),
            const SizedBox(height: 16),
            _buildSheetTextField(controller: _complementController, label: 'Complemento (Opcional)', icon: Icons.info_outline),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(flex: 3, child: _buildSheetTextField(controller: _cityController, label: 'Cidade', icon: Icons.location_city)),
                const SizedBox(width: 8),
                Expanded(flex: 1, child: _buildSheetTextField(controller: _stateController, label: 'UF', icon: Icons.map)),
              ],
            ),
            const SizedBox(height: 24),
            
            SwitchListTile(
              title: const Text(
                'Também sou Comprador',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Ative para fazer cotações de preços'),
              value: _isBuyerToo,
              activeColor: Colors.orange,
              onChanged: (val) => setState(() => _isBuyerToo = val),
            ),

            const SizedBox(height: 24),
            
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveProfile,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: _isLoading 
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Salvar na Rede CotaZap', style: TextStyle(color: Colors.white)),
              ),
            ),
            
            const SizedBox(height: 48),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.add_shopping_cart),
              title: const Text('Meus Produtos Ofertados'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Impulsionar Perfil (Destaque)'),
              trailing: const Icon(Icons.star, color: Colors.amber),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onSearchCnpj() async {
    final cleanCnpj = _cnpjController.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanCnpj.length >= 11) {
      setState(() => _isSearchingCnpj = true);
      try {
        final data = await ref.read(cnpjServiceProvider).fetchCnpjData(cleanCnpj);
        if (data != null) {
          setState(() {
            _tradeNameController.text = data.tradeName ?? data.legalName ?? "";
            _addressController.text = data.address ?? "";
            _neighborhoodController.text = data.neighborhood ?? "";
            _zipCodeController.text = data.cep ?? "";
            _complementController.text = data.complement ?? "";
            _emailController.text = data.email ?? "";
            _cityController.text = data.city ?? "";
            _stateController.text = data.state ?? "";
            if (data.phone != null) {
              _whatsappController.text = data.phone!.replaceFirst('+55 ', '').replaceFirst('55', '');
            }
          });
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Dados importados com sucesso!')));
          }
        }
      } finally {
        if (mounted) setState(() => _isSearchingCnpj = false);
      }
    }
  }

  Widget _buildSheetTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? prefixText,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.orange),
        prefixText: prefixText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
    );
  }
}
