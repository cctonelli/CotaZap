import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cota_zap/core/presentation/widgets/side_menu_drawer.dart';
import 'package:cota_zap/features/products/presentation/controllers/products_controller.dart';
import 'package:cota_zap/features/suppliers/presentation/widgets/categories_chip_bar.dart';
import 'package:cota_zap/features/suppliers/presentation/controllers/categories_controller.dart';
import 'package:cota_zap/features/admin/presentation/controllers/units_of_measure_controller.dart';
import 'package:cota_zap/drift/database.dart';

class ProductsListPage extends ConsumerWidget {
  const ProductsListPage({super.key});

  void _showAddProductSheet(BuildContext context, WidgetRef ref) {
    final descriptionController = TextEditingController();
    final unitController = TextEditingController(text: 'UN');
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
                                  if (textEditingValue.text.isEmpty) return const Iterable<UnitsOfMeasureData>.empty();
                                  return unitsState.units.where((u) => 
                                    u.code.toLowerCase().contains(textEditingValue.text.toLowerCase()) || 
                                    u.name.toLowerCase().contains(textEditingValue.text.toLowerCase())
                                  );
                                },
                                displayStringForOption: (option) => option.code.toUpperCase(),
                                onSelected: (option) => unitController.text = option.code.toUpperCase(),
                                fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                                  // Sincroniza o controller do Autocomplete com o nosso unitController
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
                    if (categoriesState.isLoading && categoriesState.categories.isEmpty)
                      const LinearProgressIndicator()
                    else
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
                          suffixIcon: categoriesState.isLoading ? const SizedBox(width: 20, height: 20, child: Padding(padding: EdgeInsets.all(8), child: CircularProgressIndicator(strokeWidth: 2))) : null,
                        ),
                      ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          ref.read(productsControllerProvider.notifier).insertProduct(
                            description: descriptionController.text,
                            unitMeasure: unitController.text,
                            sku: skuController.text.isEmpty ? null : skuController.text,
                            categoryId: selectedCatId,
                          );
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF128C7E),
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
        prefixIcon: Icon(icon, color: const Color(0xFF128C7E)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Garante que as unidades e categorias estejam carregadas
    ref.read(unitsControllerProvider.notifier).forceRefresh();
    
    final state = ref.watch(productsControllerProvider);
    final controller = ref.read(productsControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Produtos'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      drawer: const SideMenuDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddProductSheet(context, ref),
        backgroundColor: const Color(0xFF128C7E),
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
            Expanded(
              child: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state.products.isEmpty
                      ? _buildEmptyState()
                      : ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: state.products.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final product = state.products[index];
                            return _buildProductCard(product, controller);
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(Product product, ProductsController controller) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF128C7E).withOpacity(0.1),
          child: const Icon(Icons.inventory_2, color: Color(0xFF128C7E)),
        ),
        title: Text(
          product.description,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(product.unitMeasure),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (product.sku != null) 
              Text(product.sku!, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF128C7E))),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.grey),
              onPressed: () => controller.deleteProduct(product),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2_outlined, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          const Text('Nenhum produto cadastrado', style: TextStyle(fontSize: 18, color: Colors.grey)),
        ],
      ),
    );
  }
}
