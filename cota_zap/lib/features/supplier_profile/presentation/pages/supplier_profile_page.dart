import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cota_zap/core/presentation/widgets/side_menu_drawer.dart';

import 'package:cota_zap/core/network/supabase_service.dart';

class SupplierProfilePage extends ConsumerStatefulWidget {
  const SupplierProfilePage({super.key});

  @override
  ConsumerState<SupplierProfilePage> createState() => _SupplierProfilePageState();
}

class _SupplierProfilePageState extends ConsumerState<SupplierProfilePage> {
  final _tradeNameController = TextEditingController(text: 'Pneu Distribuidora Nacional');
  final _whatsappController = TextEditingController(text: '+55 11 98888-7777');
  final _addressController = TextEditingController(text: 'Rua das Borrachas, 100 - São Paulo, SP');
  bool _isLoading = false;

  @override
  void dispose() {
    _tradeNameController.dispose();
    _whatsappController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    setState(() => _isLoading = true);
    try {
      await SupabaseService.instance.updateProfile(
        table: 'suppliers',
        data: {
          'tradeName': _tradeNameController.text,
          'whatsapp': _whatsappController.text,
          'address': _addressController.text,
          'lastUpdated': DateTime.now().toIso8601String(),
        },
      );

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
            
            // Formulário de Auto-Registro
            TextFormField(
              controller: _tradeNameController,
              decoration: const InputDecoration(
                labelText: 'Nome Fantasia',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _whatsappController,
              decoration: const InputDecoration(
                labelText: 'WhatsApp do Comercial',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _addressController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Endereço / Depósito',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on),
              ),
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
}
