import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cota_zap/core/presentation/widgets/side_menu_drawer.dart';

class SupplierProductLinksPage extends ConsumerStatefulWidget {
  const SupplierProductLinksPage({super.key});

  @override
  ConsumerState<SupplierProductLinksPage> createState() => _SupplierProductLinksPageState();
}

class _SupplierProductLinksPageState extends ConsumerState<SupplierProductLinksPage> {
  // Mock data
  final List<String> _products = ['Pneu 175/70R13 Continental', 'Óleo 5W30 Sintético 1L', 'Filtro de Ar Toyota'];
  final List<String> _suppliers = ['Pneu Distribuidora Nacional', 'AutoPeças Silva', 'Distribuidor Sul'];
  
  String? _selectedProduct;
  final Map<String, Set<String>> _links = {}; // Product -> Set of Suppliers

  @override
  void initState() {
    super.initState();
    _selectedProduct = _products.first;
    // Initialize empty links
    for (var p in _products) {
      _links[p] = {};
    }
  }

  void _toggleSupplier(String supplier) {
    if (_selectedProduct == null) return;
    setState(() {
      if (_links[_selectedProduct]!.contains(supplier)) {
        _links[_selectedProduct]!.remove(supplier);
      } else {
        _links[_selectedProduct]!.add(supplier);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vínculo Fornecedores-Produtos'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      drawer: const SideMenuDrawer(),
      body: Row(
        children: [
          // Sidebar de Produtos
          Container(
            width: 280,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border(right: BorderSide(color: Colors.grey.shade300)),
            ),
            child: ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                final isSelected = _selectedProduct == product;
                return ListTile(
                  title: Text(
                    product,
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? const Color(0xFF128C7E) : null,
                    ),
                  ),
                  selected: isSelected,
                  selectedTileColor: const Color(0xFF128C7E).withOpacity(0.05),
                  trailing: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${_links[product]?.length ?? 0}',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                  onTap: () => setState(() => _selectedProduct = product),
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
                    _selectedProduct ?? 'Selecione um produto',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 32),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300,
                        childAspectRatio: 3,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                      ),
                      itemCount: _suppliers.length,
                      itemBuilder: (context, index) {
                        final supplier = _suppliers[index];
                        final isLinked = _links[_selectedProduct]?.contains(supplier) ?? false;
                        
                        return GestureDetector(
                          onTap: () => _toggleSupplier(supplier),
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
                                    supplier,
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
                      onPressed: () {
                         ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Vínculos salvos com sucesso!')),
                        );
                      },
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
