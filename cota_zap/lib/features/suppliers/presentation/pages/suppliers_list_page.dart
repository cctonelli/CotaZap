import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cota_zap/core/presentation/widgets/side_menu_drawer.dart';
import 'package:cota_zap/features/suppliers/presentation/controllers/suppliers_controller.dart';
// import 'package:cota_zap/features/suppliers/presentation/widgets/categories_chip_bar.dart'; // Removed as categories are products-only now
import 'package:cota_zap/drift/database.dart';
import 'package:cota_zap/core/services/cnpj_service.dart';
import 'package:cota_zap/core/utils/validators.dart';
import 'package:cota_zap/core/theme/app_theme.dart';

class SuppliersListPage extends ConsumerStatefulWidget {
  const SuppliersListPage({super.key});

  @override
  ConsumerState<SuppliersListPage> createState() => _SuppliersListPageState();
}

class _SuppliersListPageState extends ConsumerState<SuppliersListPage> {
  final _formKey = GlobalKey<FormState>();
  
  late final TextEditingController nameController;
  late final TextEditingController whatsappController;
  late final TextEditingController cnpjController;
  late final TextEditingController contactController;
  late final TextEditingController emailController;
  late final TextEditingController addressController;
  late final TextEditingController cityController;
  late final TextEditingController stateController;
  late final TextEditingController neighborhoodController;
  late final TextEditingController zipCodeController;
  late final TextEditingController complementController;
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    whatsappController = TextEditingController();
    cnpjController = TextEditingController();
    contactController = TextEditingController();
    emailController = TextEditingController();
    addressController = TextEditingController();
    cityController = TextEditingController();
    stateController = TextEditingController();
    neighborhoodController = TextEditingController();
    zipCodeController = TextEditingController();
    complementController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    whatsappController.dispose();
    cnpjController.dispose();
    contactController.dispose();
    emailController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    neighborhoodController.dispose();
    zipCodeController.dispose();
    complementController.dispose();
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  void _clearControllers() {
    nameController.clear();
    whatsappController.clear();
    cnpjController.clear();
    contactController.clear();
    emailController.clear();
    addressController.clear();
    cityController.clear();
    stateController.clear();
    neighborhoodController.clear();
    zipCodeController.clear();
    complementController.clear();
  }

  void _addSupplier() {
    _clearControllers();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildAddSupplierSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(suppliersControllerProvider);
    final controller = ref.read(suppliersControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(state.showNetwork ? 'Rede CotaZap' : 'Meus Fornecedores'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black87,
        actions: [
          IconButton(
            onPressed: () => searchFocusNode.requestFocus(),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      drawer: const SideMenuDrawer(),
      floatingActionButton: state.showNetwork 
          ? null 
          : FloatingActionButton(
              onPressed: _addSupplier,
              backgroundColor: AppTheme.primaryColor,
              child: const Icon(Icons.add, color: Colors.white),
            ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.grey.shade50],
          ),
        ),
        child: Column(
          children: [
            // BARRA DE PESQUISA DINÂMICA
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: TextField(
                controller: searchController,
                focusNode: searchFocusNode,
                onChanged: (value) => controller.updateSearchQuery(value),
                decoration: InputDecoration(
                  hintText: 'Buscar por Nome, CNPJ, Contato, WhatsApp...',
                  prefixIcon: const Icon(Icons.search, color: AppTheme.primaryColor),
                  suffixIcon: searchController.text.isNotEmpty 
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 20),
                        onPressed: () {
                          searchController.clear();
                          controller.updateSearchQuery('');
                        },
                      )
                    : null,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
              ),
            ),

            // SELETOR DE MODO
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
              child: SegmentedButton<bool>(
                segments: const [
                  ButtonSegment(
                    value: false, 
                    label: Text('Meus Contatos'),
                    icon: Icon(Icons.person_pin_outlined),
                  ),
                  ButtonSegment(
                    value: true, 
                    label: Text('Rede CotaZap'),
                    icon: Icon(Icons.public),
                  ),
                ],
                selected: {state.showNetwork},
                onSelectionChanged: (newSelection) {
                  controller.toggleNetworkMode();
                },
                style: SegmentedButton.styleFrom(
                  backgroundColor: Colors.grey.shade100,
                  selectedBackgroundColor: AppTheme.primaryColor,
                  selectedForegroundColor: Colors.white,
                  side: BorderSide.none,
                ),
              ),
            ),

            Expanded(
              child: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state.suppliers.isEmpty
                      ? _buildEmptyState()
                      : ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: state.suppliers.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final supplier = state.suppliers[index];
                            return _buildSupplierCard(supplier, controller, state.showNetwork);
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupplierCard(AppContact supplier, SuppliersController controller, bool isRede) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: (isRede ? Colors.orange : AppTheme.primaryColor).withOpacity(0.1),
          child: Icon(
            isRede ? Icons.verified_user : Icons.storefront, 
            color: isRede ? Colors.orange : AppTheme.primaryColor
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                supplier.tradeName,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            if (isRede)
              const Badge(
                label: Text('REDE', style: TextStyle(fontSize: 10)),
                backgroundColor: Colors.orange,
              ),
          ],
        ),
        subtitle: Text(supplier.whatsapp),
        trailing: isRede 
          ? const Icon(Icons.chevron_right, color: Colors.grey)
          : IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.grey),
              onPressed: () => controller.deleteSupplier(supplier),
            ),
        onTap: () {
          // Edit or details
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    final state = ref.read(suppliersControllerProvider);
    final controller = ref.read(suppliersControllerProvider.notifier);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              state.showNetwork ? Icons.public_off : Icons.store_mall_directory_outlined, 
              size: 80, 
              color: Colors.grey.shade300
            ),
            const SizedBox(height: 16),
            Text(
              state.searchQuery.isNotEmpty
                ? 'Nenhum fornecedor encontrado para "${state.searchQuery}"'
                : (state.showNetwork 
                    ? 'Nenhum fornecedor verificado na rede no momento.'
                    : 'Você ainda não cadastrou fornecedores.'),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 24),
            if (!state.showNetwork) ...[
              ElevatedButton.icon(
                onPressed: () => controller.toggleNetworkMode(),
                icon: const Icon(Icons.search),
                label: const Text('BUSCAR NA REDE COTAZAP'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Ou toque no + para adicionar manualmente.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ] else 
              TextButton(
                onPressed: () => controller.toggleNetworkMode(),
                child: const Text('Voltar para meus contatos'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddSupplierSheet() {
    return StatefulBuilder(
      builder: (context, setSheetState) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 24,
            left: 24,
            right: 24,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Novo Fornecedor',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSheetTextField(
                          controller: cnpjController, 
                          label: 'CNPJ / CPF', 
                          icon: Icons.badge_outlined,
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            if (val == null || val.isEmpty) return null;
                            if (!Validators.isValidCpfCnpj(val)) return 'CNPJ ou CPF inválido';
                            return null;
                          }
                        ),
                      ),
                      const SizedBox(width: 8),
                      isSearching 
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.primaryColor)),
                          )
                        : IconButton.filled(
                            onPressed: () async {
                              final cleanCnpj = cnpjController.text.replaceAll(RegExp(r'[^0-9]'), '');
                              if (cleanCnpj.length >= 11) {
                                 setSheetState(() => isSearching = true);
                                 try {
                                    final data = await ref.read(cnpjServiceProvider).fetchCnpjData(cleanCnpj);
                                    if (data != null) {
                                       nameController.text = data.tradeName ?? data.legalName ?? "";
                                       addressController.text = data.address ?? "";
                                       neighborhoodController.text = data.neighborhood ?? "";
                                       zipCodeController.text = data.cep ?? "";
                                       complementController.text = data.complement ?? "";
                                       emailController.text = data.email ?? "";
                                       cityController.text = data.city ?? "";
                                       stateController.text = data.state ?? "";
                                       if (data.phone != null) {
                                          whatsappController.text = data.phone!.replaceFirst('+55 ', '');
                                       }
                                    }
                                 } finally {
                                    setSheetState(() => isSearching = false);
                                 }
                              }
                            }, 
                            icon: const Icon(Icons.download),
                            style: IconButton.styleFrom(backgroundColor: AppTheme.primaryColor),
                          ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildSheetTextField(
                    controller: nameController, 
                    label: 'Nome / Razão Social', 
                    icon: Icons.store,
                    validator: (val) => (val == null || val.isEmpty) ? 'Obrigatório' : null,
                  ),
                  const SizedBox(height: 20),
                  _buildSheetTextField(controller: contactController, label: 'Nome do Contato', icon: Icons.person_outline),
                  const SizedBox(height: 20),
                  _buildSheetTextField(
                    controller: whatsappController, 
                    label: 'Celular / WhatsApp', 
                    icon: Icons.phone_android, 
                    prefixText: '+55 ',
                    keyboardType: TextInputType.phone,
                    validator: (val) => (val == null || val.isEmpty) ? 'Obrigatório' : null,
                  ),
                  const SizedBox(height: 20),
                  _buildSheetTextField(
                    controller: emailController, 
                    label: 'E-mail', 
                    icon: Icons.email_outlined,
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                            ref.read(suppliersControllerProvider.notifier).addSupplier(
                              name: nameController.text,
                              whatsapp: '+55 ${whatsappController.text}',
                              cnpjCpf: cnpjController.text,
                              contactName: contactController.text,
                              email: emailController.text,
                              address: addressController.text,
                              city: cityController.text,
                              uf: stateController.text,
                              neighborhood: neighborhoodController.text,
                              zipCode: zipCodeController.text,
                              complement: complementController.text,
                            );
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('CADASTRAR FORNECEDOR'),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  Widget _buildSheetTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? prefixText,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppTheme.primaryColor),
        prefixText: prefixText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
    );
  }
}
