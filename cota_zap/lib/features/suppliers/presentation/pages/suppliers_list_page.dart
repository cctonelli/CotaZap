import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cota_zap/core/presentation/widgets/side_menu_drawer.dart';
import 'package:cota_zap/features/suppliers/presentation/controllers/suppliers_controller.dart';
import 'package:cota_zap/features/suppliers/presentation/widgets/categories_chip_bar.dart';
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
  
  // Controladores de texto para o formulário de fornecedor
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
        title: const Text('Meus Fornecedores'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black87,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      drawer: const SideMenuDrawer(),
      floatingActionButton: FloatingActionButton(
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
            const CategoriesChipBar(), // Barra de Categorias
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
                            return _buildSupplierCard(supplier, controller);
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupplierCard(AppContact supplier, SuppliersController controller) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
          child: const Icon(Icons.storefront, color: AppTheme.primaryColor),
        ),
        title: Text(
          supplier.tradeName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(supplier.whatsapp),
        trailing: IconButton(
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.store_mall_directory_outlined, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          const Text(
            'Nenhum fornecedor cadastrado',
            style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          const Text(
            'Toque no + para adicionar seu primeiro fornecedor',
            style: TextStyle(color: Colors.grey),
          ),
        ],
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
                  const SizedBox(height: 8),
                  const Text(
                    'Cadastre um fornecedor parceiro para enviar cotações via WhatsApp.',
                    style: TextStyle(color: Colors.grey),
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
                                       if (context.mounted) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Dados importados com sucesso!'))
                                          );
                                       }
                                    } else {
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                           const SnackBar(content: Text('Empresa não encontrada ou erro na busca.'))
                                         );
                                      }
                                    }
                                 } finally {
                                    if (context.mounted) {
                                      setSheetState(() => isSearching = false);
                                    }
                                 }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                   const SnackBar(content: Text('Informe um CNPJ de 14 dígitos para buscar'))
                                 );
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
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) {
                      if (val != null && val.isNotEmpty && !val.contains('@')) return 'E-mail inválido';
                      return null;
                    }
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                       Expanded(child: _buildSheetTextField(controller: zipCodeController, label: 'CEP', icon: Icons.pin_drop_outlined, keyboardType: TextInputType.number)),
                       const SizedBox(width: 8),
                       Expanded(child: _buildSheetTextField(controller: neighborhoodController, label: 'Bairro', icon: Icons.maps_home_work_outlined)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildSheetTextField(controller: addressController, label: 'Logradouro e Número', icon: Icons.location_on_outlined),
                  const SizedBox(height: 20),
                  _buildSheetTextField(controller: complementController, label: 'Complemento (Opcional)', icon: Icons.info_outline),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(flex: 3, child: _buildSheetTextField(controller: cityController, label: 'Cidade', icon: Icons.location_city)),
                      const SizedBox(width: 8),
                      Expanded(flex: 1, child: _buildSheetTextField(controller: stateController, label: 'UF', icon: Icons.map)),
                    ],
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
                      child: const Text(
                        'CADASTRAR FORNECEDOR',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.1,
                        ),
                      ),
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
