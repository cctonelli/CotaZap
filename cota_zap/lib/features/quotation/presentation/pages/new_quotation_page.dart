import 'package:cota_zap/drift/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cota_zap/core/di/injection.dart';
import 'package:cota_zap/drift/daos/contacts_dao.dart';
import 'package:cota_zap/core/presentation/widgets/side_menu_drawer.dart';
import 'package:cota_zap/features/quotation/presentation/controllers/new_quotation_controller.dart';



class NewQuotationPage extends ConsumerWidget {
  const NewQuotationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(newQuotationControllerProvider);
    final controller = ref.read(newQuotationControllerProvider.notifier);
    final productsDao = ref.watch(productsDaoProvider);
    final contactsDao = ref.watch(contactsDaoProvider);
    final userId = ref.watch(userIdProvider);

    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Cotação'),
        backgroundColor: const Color(0xFF075E54),
        foregroundColor: Colors.white,
      ),
      drawer: const SideMenuDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. COMPRADOR ATIVO
            StreamBuilder<AppContact?>(
              stream: userId != null ? contactsDao.getFirstBuyer(userId).asStream() : const Stream.empty(),
              builder: (context, snapshot) {
                final buyer = snapshot.data;
                if (buyer == null) return const Center(child: Text('Cadastre seu perfil de Comprador no Menu Lateral'));
                return Card(
                  color: Colors.grey[50],
                  child: ListTile(
                    leading: const CircleAvatar(backgroundColor: Color(0xFF128C7E), child: Icon(Icons.person, color: Colors.white)),
                    title: Text('${buyer.tradeName}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('WhatsApp: ${buyer.whatsapp}'),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),

            // 2. BUSCA DE PRODUTOS
            TextField(
              controller: searchController,
              onSubmitted: (val) async {
                final found = await productsDao.searchProducts(val);
                if (found.isNotEmpty) {
                  controller.addProduct(found.first);
                  searchController.clear();
                }
              },
              decoration: InputDecoration(
                hintText: 'Buscar Produto pelo Nome...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 16),

            // 3. PRODUTOS SELECIONADOS
            if (state.selectedProducts.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Column(
                    children: [
                      Icon(Icons.shopping_basket_outlined, size: 64, color: Colors.grey),
                      Text('Selecione produtos para cotar', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              )
            else
              ...state.selectedProducts.entries.map((entry) => SelectedProductCard(
                    product: entry.key,
                    quantity: entry.value,
                    onUpdateQuantity: (v) => controller.updateQuantity(entry.key, v),
                    onRemove: () => controller.removeProduct(entry.key),
                  )),

            const SizedBox(height: 24),

            // 4. CONFIGURAÇÕES DA COTAÇÃO
            const Text('Configurações do Envio', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: ['CIF', 'FOB'].contains(state.deliveryType) ? state.deliveryType : 'CIF',
                          decoration: const InputDecoration(labelText: 'Tipo de Frete'),
                          items: const [
                            DropdownMenuItem(value: 'CIF', child: Text('CIF (Entregue)')),
                            DropdownMenuItem(value: 'FOB', child: Text('FOB (Retira)')),
                          ],
                          onChanged: (v) => controller.updateDeliveryType(v!),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          initialValue: state.leadTimeDefault.toString(),
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'Prazo Entrega (Dias)'),
                          onChanged: (v) => controller.updateLeadTime(int.tryParse(v) ?? 0),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: ['Boleto', 'PIX', 'Boleto/PIX', 'Cartão', 'Transferência'].contains(state.paymentCondition) 
                                ? state.paymentCondition 
                                : 'Boleto',
                          decoration: const InputDecoration(labelText: 'Forma Pagamento'),
                          items: const [
                            DropdownMenuItem(value: 'Boleto', child: Text('Boleto')),
                            DropdownMenuItem(value: 'PIX', child: Text('PIX')),
                            DropdownMenuItem(value: 'Boleto/PIX', child: Text('Boleto/PIX')),
                            DropdownMenuItem(value: 'Cartão', child: Text('Cartão')),
                            DropdownMenuItem(value: 'Transferência', child: Text('Transferência')),
                          ],
                          onChanged: (v) => controller.updatePaymentCondition(v!),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          initialValue: state.paymentTermDays.toString(),
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'Prazo Pag. (Dias)'),
                          onChanged: (v) => controller.updatePaymentTerm(int.tryParse(v) ?? 0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 5. SELEÇÃO DE FORNECEDORES
            const Text('Selecionar Fornecedores', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildSupplierSelection(context, state, controller, contactsDao, userId),

            const SizedBox(height: 32),

            // 6. REDE COTAZAP (Sugestões Inteligentes)
            RedeCotazapSection(
              contactsDao: contactsDao,
              onSelect: (id) => controller.toggleSupplierSelection(id),
              selectedIds: state.selectedSupplierIds,
              categoryIds: state.selectedProducts.keys.map((p) => p.categoryId).whereType<int>().toSet().toList(),
            ),

            // 7. PREVIEW DA MENSAGEM
            QuotationMessagePreview(state: state),

            const SizedBox(height: 40),

            // 8. BOTÃO ENVIAR
            SizedBox(
              width: double.infinity,
              height: 64,
              child: ElevatedButton.icon(
                onPressed: state.selectedProducts.isEmpty || state.selectedSupplierIds.isEmpty || state.isLoading
                    ? null
                    : () => controller.sendQuotation(),
                icon: state.isLoading 
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : const Icon(Icons.send, size: 28),
                label: Text(
                  state.isLoading ? 'PROCESSANDO...' : 'DISPARAR COTAÇÕES (${state.selectedProducts.length} itens)',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF25D366),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 4,
                ),
              ),
            ),
            if (state.errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(state.errorMessage!, style: const TextStyle(color: Colors.red)),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupplierSelection(BuildContext context, NewQuotationState state, NewQuotationController controller, ContactsDao dao, String? userId) {
    return StreamBuilder<List<AppContact>>(
      stream: userId != null ? dao.watchSuppliers(userId) : const Stream.empty(),
      builder: (context, snapshot) {
        final suppliers = snapshot.data ?? [];
        if (suppliers.isEmpty) return const Text('Nenhum fornecedor cadastrado.', style: TextStyle(color: Colors.grey));
        
        return Container(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: suppliers.length,
            itemBuilder: (context, index) {
              final s = suppliers[index];
              final isSelected = state.selectedSupplierIds.contains(s.id);

              return GestureDetector(
                onTap: () => controller.toggleSupplierSelection(s.id),
                child: Container(
                  width: 140,
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF128C7E).withOpacity(0.1) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? const Color(0xFF128C7E) : Colors.grey.shade200,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: isSelected ? const Color(0xFF128C7E) : Colors.grey.shade100,
                        child: Icon(
                          Icons.store, 
                          color: isSelected ? Colors.white : Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        s.tradeName,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class SelectedProductCard extends StatelessWidget {
  final Product product;
  final double quantity;
  final ValueChanged<double> onUpdateQuantity;
  final VoidCallback onRemove;

  const SelectedProductCard({
    super.key,
    required this.product,
    required this.quantity,
    required this.onUpdateQuantity,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.description, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('${product.unitMeasure} • ${product.packagingType}', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                ],
              ),
            ),
            Container(
              width: 80,
              decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
              child: TextFormField(
                initialValue: quantity.toString(),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
                decoration: const InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.all(8)),
                onChanged: (v) => onUpdateQuantity(double.tryParse(v) ?? 1.0),
              ),
            ),
            IconButton(
              onPressed: onRemove,
              icon: const Icon(Icons.delete_outline, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

class QuotationMessagePreview extends StatelessWidget {
  final NewQuotationState state;
  const QuotationMessagePreview({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final buffer = StringBuffer();
    buffer.writeln('📋 *NOVA COTAÇÃO - COTAZAP*');
    buffer.writeln('---');
    for (var entry in state.selectedProducts.entries) {
      buffer.writeln('• ${entry.value} x ${entry.key.description}');
    }
    buffer.writeln('---');
    buffer.writeln('📍 Frete: ${state.deliveryType}');
    buffer.writeln('📅 Entrega: ${state.leadTimeDefault} dias');
    buffer.writeln('💰 Pagamento: ${state.paymentCondition} (${state.paymentTermDays} dias)');
    buffer.writeln('---');
    buffer.write('Responder via link CotaZap: [LINK]');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFDCF8C6),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF25D366).withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.remove_red_eye, size: 16, color: Color(0xFF075E54)),
              SizedBox(width: 8),
              Text('Pré-visualização da Mensagem', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF075E54))),
            ],
          ),
          const SizedBox(height: 12),
          Text(buffer.toString(), style: const TextStyle(fontFamily: 'monospace', fontSize: 13)),
        ],
      ),
    );
  }
}

class RedeCotazapSection extends StatelessWidget {
  final ContactsDao contactsDao;
  final Function(int) onSelect;
  final List<int> selectedIds;
  final List<int> categoryIds;

  const RedeCotazapSection({
    super.key, 
    required this.contactsDao,
    required this.onSelect,
    required this.selectedIds,
    required this.categoryIds,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<AppContact>>(
      stream: categoryIds.isEmpty 
          ? contactsDao.watchRedeSuppliers()
          : contactsDao.watchRecommendedSuppliers(categoryIds),
      builder: (context, snapshot) {
        final rede = snapshot.data ?? [];
        if (rede.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.bolt, color: Colors.orange, size: 20),
                const SizedBox(width: 8),
                const Text('🔥 Fornecedores Recomendados', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const Text(
               'Fornecedores verificados pela Rede CotaZap com melhores preços e prazos.',
               style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 12),
            Container(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: rede.length,
                itemBuilder: (context, index) {
                  final s = rede[index];
                  final isSelected = selectedIds.contains(s.id);

                  return GestureDetector(
                    onTap: () => onSelect(s.id),
                    child: Container(
                      width: 220,
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.orange.withOpacity(0.05) : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? Colors.orange : Colors.orange.withOpacity(0.2),
                          width: 2,
                        ),
                        boxShadow: [
                          if (!isSelected) BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(color: Colors.orange.withOpacity(0.1), shape: BoxShape.circle),
                                child: const Icon(Icons.verified, color: Colors.orange, size: 16),
                              ),
                              const SizedBox(width: 8),
                              Expanded(child: Text(s.tradeName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 14),
                              const SizedBox(width: 4),
                              Text('${(s.priorityScore / 20).toStringAsFixed(1)}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                              const SizedBox(width: 12),
                              const Icon(Icons.access_time, color: Colors.blue, size: 14),
                              const SizedBox(width: 4),
                              const Text('24h', style: TextStyle(fontSize: 12, color: Colors.blue, fontWeight: FontWeight.w600)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          if (isSelected)
                            const Center(child: Text('ADICIONADO', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 12)))
                          else
                            Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(8)),
                                child: const Text('ADICIONAR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10)),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
