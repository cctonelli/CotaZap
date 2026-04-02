import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cota_zap/core/presentation/widgets/side_menu_drawer.dart';
import 'package:cota_zap/core/network/supabase_service.dart';

class BuyerProfilePage extends ConsumerStatefulWidget {
  const BuyerProfilePage({super.key});

  @override
  ConsumerState<BuyerProfilePage> createState() => _BuyerProfilePageState();
}

class _BuyerProfilePageState extends ConsumerState<BuyerProfilePage> {
  final _nameController = TextEditingController(text: 'Comprador Demonstrativo');
  final _companyController = TextEditingController(text: 'CotaZap Soluções');
  final _emailController = TextEditingController(text: 'comprador@cotazap.com.br');
  final _whatsappController = TextEditingController(text: '+55 (11) 99999-9999');
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _companyController.dispose();
    _emailController.dispose();
    _whatsappController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    setState(() => _isLoading = true);
    try {
      await SupabaseService.instance.updateProfile(
        table: 'buyers',
        data: {
          'name': _nameController.text,
          'company': _companyController.text,
          'email': _emailController.text,
          'whatsapp': _whatsappController.text,
          'lastUpdated': DateTime.now().toIso8601String(),
        },
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Perfil salvo no Supabase!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ Erro no Supabase: ${e.toString()}')),
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
        title: const Text('Meu Perfil de Comprador'),
        centerTitle: true,
        backgroundColor: const Color(0xFF075E54),
        foregroundColor: Colors.white,
      ),
      drawer: const SideMenuDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xFFE8E8E8),
                    child: Icon(Icons.person, size: 50, color: Color(0xFF075E54)),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: const Color(0xFF25D366),
                      child: IconButton(
                        icon: const Icon(Icons.edit, size: 18, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            _buildField(label: 'Nome Completo', controller: _nameController),
            _buildField(label: 'Empresa', controller: _companyController),
            _buildField(label: 'E-mail', controller: _emailController),
            _buildField(label: 'Telefone/WhatsApp', controller: _whatsappController, isPhone: true),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _saveProfile,
              icon: _isLoading ? const SizedBox.shrink() : const Icon(Icons.save),
              label: _isLoading 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Salvar Alterações'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF075E54),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField({required String label, required TextEditingController controller, bool isPhone = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          prefixIcon: isPhone ? const Icon(Icons.phone) : null,
        ),
      ),
    );
  }
}
