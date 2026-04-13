import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cota_zap/core/presentation/widgets/side_menu_drawer.dart';
import 'package:cota_zap/features/products/presentation/controllers/products_controller.dart';
import 'package:cota_zap/features/suppliers/presentation/controllers/categories_controller.dart';
import 'package:cota_zap/features/admin/presentation/controllers/units_of_measure_controller.dart';
import 'package:cota_zap/drift/database.dart';
import 'package:cota_zap/core/theme/app_theme.dart';
import 'package:cota_zap/features/suppliers/presentation/widgets/categories_chip_bar.dart';

class ProductsListPage extends ConsumerStatefulWidget {
  const ProductsListPage({super.key});

  @override
  ConsumerState<ProductsListPage> createState() => _ProductsListPageState();
}

class _ProductsListPageState extends ConsumerState<ProductsListPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productsControllerProvider);
    final controller = ref.read(productsControllerProvider.notifier);

    // Sincroniza o controller com o estado caso mude externamente
    ref.listen<String>(productsControllerProvider.select((s) => s.searchQuery), (prev, next) {
      if (next != _searchController.text) {
        _searchController.text = next;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(state.showNetwork ? 'Rede CotaZap' : 'Meus Produtos'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      drawer: const SideMenuDrawer(),
      floatingActionButton: state.showNetwork 
          ? null 
          : FloatingActionButton(
              onPressed: () => _showAddProductSheet(context, ref),
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
            const CategoriesChipBar(),
            // BARRA DE PESQUISA DINÂMICA
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                onChanged: (value) => controller.updateSearchQuery(value),
                decoration: InputDecoration(
                  hintText: 'Pesquisar por produto ou categoria...',
                  prefixIcon: const Icon(Icons.search, color: AppTheme.primaryColor),
                  suffixIcon: state.searchQuery.isNotEmpty 
                    ? IconButton(
                        icon: const Icon(Icons.clear), 
                        onPressed: () {
                          _searchController.clear();
                          controller.updateSearchQuery('');
                        },
                      )
                    : null,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
                  ),
                ),
              ),
            ),
            
            // SELETOR DE MODO
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: SegmentedButton<bool>(
                segments: const [
                  ButtonSegment(
                    value: false, 
                    label: Text('Meus Produtos'),
                    icon: Icon(Icons.inventory_2_outlined),
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
                  : state.products.isEmpty
                      ? _buildEmptyState(ref)
                      : ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: state.products.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final product = state.products[index];
                            return _buildProductCard(product, controller, state.showNetwork);
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(Product product, ProductsController controller, bool isRede) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: (isRede ? Colors.orange : AppTheme.primaryColor).withOpacity(0.1),
          child: Icon(
            isRede ? Icons.verified : Icons.inventory_2, 
            color: isRede ? Colors.orange : AppTheme.primaryColor
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                product.description,
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
        subtitle: Text(product.unitMeasure),
        trailing: isRede 
          ? const Icon(Icons.chevron_right, color: Colors.grey)
          : IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.grey),
              onPressed: () => controller.deleteProduct(product),
            ),
      ),
    );
  }

  Widget _buildEmptyState(WidgetRef ref) {
    final state = ref.read(productsControllerProvider);
    final controller = ref.read(productsControllerProvider.notifier);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              state.showNetwork ? Icons.search_off : Icons.inventory_2_outlined, 
              size: 80, 
              color: Colors.grey.shade300
            ),
            const SizedBox(height: 16),
            Text(
              state.showNetwork 
                ? 'Nenhum item encontrado na rede para esta categoria.'
                : 'Seu catálogo privado está vazio.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 24),
            if (!state.showNetwork) ...[
              ElevatedButton.icon(
                onPressed: () => controller.toggleNetworkMode(),
                icon: const Icon(Icons.public),
                label: const Text('BUSCAR NA REDE COTAZAP'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Ou use o botão + para cadastrar manualmente.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ] else 
              TextButton(
                onPressed: () => controller.toggleNetworkMode(),
                child: const Text('Voltar para meus produtos'),
              ),
          ],
        ),
      ),
    );
  }

  void _showAddProductSheet(BuildContext context, WidgetRef ref) {
    final descriptionController = TextEditingController();
    final unitController = TextEditingController();
    final skuController = TextEditingController();
    int? selectedCatId;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Consumer(
        builder: (context, ref, child) {
          final categoriesState = ref.watch(categoriesControllerProvider);
          
          return StatefulBuilder(
            builder: (context, setModalState) => Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 24, left: 24, right: 24,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Novo Produto', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    _buildSheetTextField(controller: descriptionController, label: 'Descrição do Produto', icon: Icons.description),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Consumer(
                            builder: (context, ref, _) {
                              final unitsState = ref.watch(unitsControllerProvider);
                              return Autocomplete<UnitsOfMeasureData>(
                                initialValue: TextEditingValue(text: unitController.text),
                                optionsBuilder: (TextEditingValue textEditingValue) {
                                  if (textEditingValue.text.isEmpty) {
                                    return unitsState.units.take(10);
                                  }
                                  return unitsState.units.where((u) => 
                                    u.code.toLowerCase().contains(textEditingValue.text.toLowerCase()) || 
                                    u.name.toLowerCase().contains(textEditingValue.text.toLowerCase())
                                  );
                                },
                                displayStringForOption: (option) => option.code.toUpperCase(),
                                onSelected: (option) => unitController.text = option.code.toUpperCase(),
                                fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                                  controller.text = unitController.text;
                                  controller.addListener(() => unitController.text = controller.text);
                                  
                                  return _buildSheetTextField(
                                    controller: controller,
                                    label: 'Unidade',
                                    icon: Icons.straighten,
                                    focusNode: focusNode,
                                  );
                                },
                                optionsViewBuilder: (context, onSelected, options) {
                                  return Align(
                                    alignment: Alignment.topLeft,
                                    child: Material(
                                      elevation: 4,
                                      borderRadius: BorderRadius.circular(12),
                                      child: SizedBox(
                                        width: 200,
                                        child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          itemCount: options.length,
                                          itemBuilder: (context, index) {
                                            final option = options.elementAt(index);
                                            return ListTile(
                                              title: Text(option.code.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                              subtitle: Text(option.name),
                                              onTap: () => onSelected(option),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: _buildSheetTextField(controller: skuController, label: 'SKU / Código', icon: Icons.qr_code)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text('Categoria', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<int>(
                        value: selectedCatId,
                        items: [
                          const DropdownMenuItem(value: null, child: Text('Sem Categoria')),
                          ...categoriesState.categories.map((c) => DropdownMenuItem(value: c.id, child: Text(c.name))),
                        ],
                        onChanged: (val) => setModalState(() => selectedCatId = val),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                        ),
                      ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (descriptionController.text.isEmpty || unitController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Por favor, preencha descrição e unidade.')),
                            );
                            return;
                          }

                          final success = await ref.read(productsControllerProvider.notifier).insertProduct(
                            description: descriptionController.text,
                            unitMeasure: unitController.text,
                            sku: skuController.text.isEmpty ? null : skuController.text,
                            categoryId: selectedCatId,
                          );

                          if (mounted) {
                            if (success) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('✅ Produto cadastrado com sucesso!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            } else {
                              final error = ref.read(productsControllerProvider).errorMessage ?? 'Erro desconhecido';
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('❌ Erro ao cadastrar: $error'),
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                  margin: const EdgeInsets.only(bottom: 150, left: 20, right: 20),
                                  duration: const Duration(seconds: 10),
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: const Text('CADASTRAR PRODUTO', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSheetTextField({
    required TextEditingController controller, 
    required String label, 
    required IconData icon,
    FocusNode? focusNode,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppTheme.primaryColor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
    );
  }
}
