import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cota_zap/drift/database.dart';
import 'package:cota_zap/features/products/presentation/controllers/products_controller.dart';
import 'package:cota_zap/features/suppliers/presentation/controllers/suppliers_controller.dart';
import 'package:cota_zap/core/di/injection.dart';
import 'package:cota_zap/core/utils/app_logger.dart';
import 'package:cota_zap/core/presentation/widgets/side_menu_drawer.dart';

class SupplierProductLinksPage extends ConsumerStatefulWidget {
  const SupplierProductLinksPage({super.key});

  @override
  ConsumerState<SupplierProductLinksPage> createState() => _SupplierProductLinksPageState();
}

class _SupplierProductLinksPageState extends ConsumerState<SupplierProductLinksPage> {
  Product? _selectedProduct;
  final Set<int> _currentSupplierIds = {}; // Local state for the selected product
  bool _isLoadingLinks = false;

  @override
  void initState() {
    super.initState();
    // Inicia a carga após o primeiro frame
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final products = ref.read(productsControllerProvider).products;
      if (products.isNotEmpty) {
        setState(() => _selectedProduct = products.first);
        _loadLinks(products.first.id);
      }
    });
  }

  Future<void> _loadLinks(int productId) async {
    setState(() => _isLoadingLinks = true);
    try {
      final dao = ref.read(productsDaoProvider);
      final links = await dao.getSuppliersForProduct(productId);
      if (mounted) {
        setState(() {
          _currentSupplierIds.clear();
          _currentSupplierIds.addAll(links.map((l) => l.supplierId));
          _isLoadingLinks = false;
        });
      }
    } catch (e) {
      AppLogger.error('Erro ao carregar vínculos', error: e);
      if (mounted) {
        setState(() => _isLoadingLinks = false);
      }
    }
  }

  void _toggleSupplier(int supplierId) {
    setState(() {
      if (_currentSupplierIds.contains(supplierId)) {
        _currentSupplierIds.remove(supplierId);
      } else {
        _currentSupplierIds.add(supplierId);
      }
    });
  }

  Future<void> _saveLinks() async {
    if (_selectedProduct == null) return;
    
    setState(() => _isLoadingLinks = true);
    try {
      final dao = ref.read(productsDaoProvider);
      
      // 1. Limpa vínculos atuais do produto
      final existing = await dao.getSuppliersForProduct(_selectedProduct!.id);
      for (var link in existing) {
        await dao.unlinkProductFromSupplier(_selectedProduct!.id, link.supplierId);
      }

      // 2. Insere novos vínculos
      for (var suppId in _currentSupplierIds) {
        await dao.linkProductToSupplier(_selectedProduct!.id, suppId);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Vínculos salvos com sucesso!')),
        );
      }
    } catch (e) {
      AppLogger.error('Erro ao salvar vínculos', error: e);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoadingLinks = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productsControllerProvider).products;
    final suppliers = ref.watch(suppliersControllerProvider).suppliers;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vínculo Fornecedores-Produtos'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      drawer: const SideMenuDrawer(),
      body: products.isEmpty 
        ? const Center(child: Text('Nenhum produto cadastrado para vincular.'))
        : Row(
            children: [
              // Sidebar de Produtos
              Container(
                width: 280,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  border: Border(right: BorderSide(color: Colors.grey.shade300)),
                ),
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    final isSelected = _selectedProduct?.id == product.id;
                    return ListTile(
                      title: Text(
                        product.description,
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? const Color(0xFF128C7E) : null,
                        ),
                      ),
                      selected: isSelected,
                      selectedTileColor: const Color(0xFF128C7E).withOpacity(0.05),
                      onTap: () {
                        setState(() => _selectedProduct = product);
                        _loadLinks(product.id);
                      },
                    );
                  },
                ),
              ),
              
              // Lista de Seleção de Fornecedores
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selecione quem fornece:',
                        style: TextStyle(fontSize: 14, color: Colors.grey.shade600, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _selectedProduct?.description ?? 'Selecione um produto',
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 32),
                      _isLoadingLinks 
                        ? const Expanded(child: Center(child: CircularProgressIndicator()))
                        : Expanded(
                            child: suppliers.isEmpty 
                              ? const Center(child: Text('Nenhum fornecedor cadastrado.'))
                              : GridView.builder(
                                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 300,
                                  childAspectRatio: 3,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16,
                                ),
                                itemCount: suppliers.length,
                                itemBuilder: (context, index) {
                                  final supplier = suppliers[index];
                                  final isLinked = _currentSupplierIds.contains(supplier.id);
                                  
                                  return GestureDetector(
                                    onTap: () => _toggleSupplier(supplier.id),
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 200),
                                      decoration: BoxDecoration(
                                        color: isLinked ? const Color(0xFF128C7E) : Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: isLinked ? const Color(0xFF128C7E) : Colors.grey.shade300,
                                        ),
                                        boxShadow: isLinked ? [
                                          BoxShadow(
                                            color: const Color(0xFF128C7E).withOpacity(0.3),
                                            blurRadius: 8,
                                            offset: const Offset(0, 4),
                                          )
                                        ] : null,
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: Row(
                                        children: [
                                          Icon(
                                            isLinked ? Icons.check_circle : Icons.add_circle_outline,
                                            color: isLinked ? Colors.white : Colors.grey,
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              supplier.tradeName,
                                              style: TextStyle(
                                                color: isLinked ? Colors.white : Colors.black87,
                                                fontWeight: isLinked ? FontWeight.bold : FontWeight.normal,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                          ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton.icon(
                          onPressed: _isLoadingLinks ? null : _saveLinks,
                          icon: const Icon(Icons.save, color: Colors.white),
                          label: const Text('SALVAR VÍNCULOS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF128C7E),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
