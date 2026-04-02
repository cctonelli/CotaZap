import 'package:cota_zap/drift/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cota_zap/core/di/injection.dart';
import 'package:cota_zap/drift/daos/suppliers_dao.dart';
import 'package:cota_zap/core/presentation/widgets/side_menu_drawer.dart';



class NewQuotationPage extends ConsumerStatefulWidget {
  const NewQuotationPage({super.key});

  @override
  ConsumerState<NewQuotationPage> createState() => _NewQuotationPageState();
}

class _NewQuotationPageState extends ConsumerState<NewQuotationPage> {
  final TextEditingController _searchController = TextEditingController();
  String _deliveryType = 'CIF';
  int _leadTime = 3;
  int _paymentTermDays = 0; // v1.4
  String _paymentCondition = 'Boleto/PIX'; // v1.4
  
  // Mapa de produtos selecionados e suas quantidades
  Map<Product, double> _selectedProducts = {};
  


  
  @override
  Widget build(BuildContext context) {
    final buyersDao = ref.watch(buyersDaoProvider);
    final suppliersDao = ref.watch(suppliersDaoProvider);
    final productsDao = ref.watch(productsDaoProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Cotação'),
        backgroundColor: const Color(0xFF075E54), // Whatsapp dark green
        foregroundColor: Colors.white,
      ),
      drawer: const SideMenuDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. SELEÇÃO DE COMPRADOR (Assumindo o primeiro cadastrado)
            StreamBuilder<Buyer?>(
              stream: buyersDao.getFirstBuyer().asStream(),
              builder: (context, snapshot) {
                final buyer = snapshot.data;
                if (buyer == null) {
                  return const Text('Cadastre um comprador primeiro');
                }
                return ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text('${buyer.name} - ${buyer.company}'),
                  subtitle: Text('WhatsApp: ${buyer.whatsapp}'),
                  trailing: const Icon(Icons.edit),
                );
              },
            ),
            const Divider(),

            // 2. BUSCA DE PRODUTOS
            TextField(
              controller: _searchController,
              onSubmitted: (val) async {
                final found = await productsDao.searchProducts(val);
                if (found.isNotEmpty) {
                  setState(() {
                    _selectedProducts[found.first] = 1.0;
                    _searchController.clear();
                  });
                }
              },
              decoration: InputDecoration(
                hintText: 'Buscar Produto...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),

            // 3. LISTA DE PRODUTOS SELECIONADOS
            if (_selectedProducts.isEmpty)
              const Center(child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Nenhum produto selecionado'),
              ))
            else
              ..._selectedProducts.entries.map((entry) {
                final product = entry.key;
                final qty = entry.value;
                return _buildProductCard(product, qty, suppliersDao);
              }).toList(),

            const SizedBox(height: 24),
            
            // NOVO: SEÇÃO REDE COTAZAP (OPCIONAL/COLAPSÁVEL)
            _buildRedeCotazapSection(suppliersDao),

            const SizedBox(height: 24),

            // 4. CONFIGURAÇÕES GLOBAIS
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _deliveryType,
                    decoration: const InputDecoration(labelText: 'Frete'),
                    items: const [
                      DropdownMenuItem(value: 'CIF', child: Text('CIF')),
                      DropdownMenuItem(value: 'FOB', child: Text('FOB')),
                    ],
                    onChanged: (v) => setState(() => _deliveryType = v!),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    initialValue: _leadTime.toString(),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Prazo Entrega (Dias)'),
                    onChanged: (v) => _leadTime = int.tryParse(v) ?? 3,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: _paymentCondition,
                    decoration: const InputDecoration(labelText: 'Pagamento (Boleto/PIX)'),
                    onChanged: (v) => setState(() => _paymentCondition = v),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    initialValue: _paymentTermDays.toString(),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Prazo Pag. (Dias)'),
                    onChanged: (v) => _paymentTermDays = int.tryParse(v) ?? 0,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // 5. BOTÃO ENVIAR
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: _selectedProducts.isEmpty ? null : () {
                   ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Disparando cotações via Evolution API...')),
                  );
                },
                icon: const Icon(Icons.send),
                label: Text('ENVIAR PARA ${_selectedProducts.length} ITENS', 
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF25D366),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey[300],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRedeCotazapSection(SuppliersDao dao) {
    return StreamBuilder<List<Supplier>>(
      stream: dao.watchRedeSuppliers(),
      builder: (context, snapshot) {
        final redeSuppliers = snapshot.data ?? [];
        if (redeSuppliers.isEmpty) {
          return const SizedBox.shrink(); // Não exibir se não houver sugestões
        }

        return ExpansionTile(
          leading: const Icon(Icons.bolt, color: Colors.orange),
          title: Text('Rede CotaZap (${redeSuppliers.length} Sugestões)', 
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
          subtitle: const Text('Fornecedores globais verificados pela plataforma', 
            style: TextStyle(fontSize: 12)),
          children: redeSuppliers.map((s) => ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.orange[100],
              child: const Icon(Icons.verified, color: Colors.orange, size: 16),
            ),
            title: Text(s.tradeName),
            subtitle: Text('WhatsApp: ${s.whatsapp}'),
            trailing: Checkbox(
              value: false, // Lógica de seleção a implementar
              onChanged: (v) {
                // TODO: Adicionar aos destinatários da cotação
              },
            ),
          )).toList(),
        );
      },
    );
  }

  Widget _buildProductCard(Product product, double qty, SuppliersDao suppliersDao) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          ListTile(
            title: Text(product.description, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${product.unitMeasure} - ${product.packagingType}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 60,
                  child: TextFormField(
                    initialValue: qty.toString(),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (v) {
                      final val = double.tryParse(v);
                      if (val != null) {
                        _selectedProducts[product] = val;
                      }
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.red),
                  onPressed: () => setState(() => _selectedProducts.remove(product)),
                ),
              ],
            ),
          ),
          // Seleção de Fornecedores rápidos para este produto
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8,
              children: [
                ActionChip(
                  avatar: const Icon(Icons.add, size: 16),
                  label: const Text('Add Fornecedor'),
                  onPressed: () {
                    // Abrir seleção de fornecedores vinculados
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
