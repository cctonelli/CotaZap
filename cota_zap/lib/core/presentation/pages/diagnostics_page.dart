import 'package:flutter/material.dart';
import 'package:cota_zap/core/network/supabase_service.dart';
import 'package:cota_zap/drift/database.dart';
import 'package:cota_zap/core/di/injection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cota_zap/features/suppliers/presentation/controllers/categories_controller.dart';
import 'package:cota_zap/features/suppliers/presentation/controllers/suppliers_controller.dart';

class DiagnosticsPage extends ConsumerWidget {
  const DiagnosticsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.read(databaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnósticos de Sistema'),
        backgroundColor: const Color(0xFF075E54),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionHeader('Conexão Nuvem (Supabase)'),
          FutureBuilder(
            future: _checkSupabaseConnection(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Card(child: ListTile(title: Text('Testando conexão...'), trailing: CircularProgressIndicator()));
              }
              final bool ok = snapshot.data ?? false;
              return Card(
                color: ok ? Colors.green[50] : Colors.red[50],
                child: ListTile(
                  leading: Icon(ok ? Icons.check_circle : Icons.error, color: ok ? Colors.green : Colors.red),
                  title: Text(ok ? 'Supabase Conectado' : 'Erro de Conexão Supabase'),
                  subtitle: Text(ok ? 'O app está conseguindo falar com o banco online.' : 'Verifique sua internet ou chaves de API.'),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('Banco de Dados Local (Drift)'),
          _buildDriftStatus(db, ref),
          const SizedBox(height: 24),
          _buildSectionHeader('Ações de Sincronização'),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.sync, color: Color(0xFF128C7E)),
                  title: const Text('Forçar Sync Categorias'),
                  subtitle: const Text('Busca novamente as categorias do Supabase'),
                  trailing: IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: () => ref.read(categoriesControllerProvider.notifier).forceRefresh(),
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.sync, color: Color(0xFF128C7E)),
                  title: const Text('Forçar Sync Fornecedores'),
                  subtitle: const Text('Busca novamente os fornecedores do Supabase'),
                  trailing: IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: () => ref.read(suppliersControllerProvider.notifier).forceRefresh(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('Informações de Sessão'),
          Card(
            child: ListTile(
              title: const Text('Perfil Ativo'),
              subtitle: Text(ref.watch(userRoleProvider).toString()),
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back),
            label: const Text('VOLTAR AO APP'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: const Color(0xFF128C7E),
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 13),
      ),
    );
  }

  Future<bool> _checkSupabaseConnection() async {
    try {
      await SupabaseService.client.from('product_categories').select().limit(1);
      return true;
    } catch (_) {
      return false;
    }
  }

  Widget _buildDriftStatus(AppDatabase db, WidgetRef ref) {
    return FutureBuilder(
      future: Future.wait([
        db.select(db.products).get().then((value) => value.length),
        db.select(db.appContacts).get().then((value) => value.length),
        db.select(db.quotations).get().then((value) => value.length),
        db.select(db.productCategories).get().then((value) => value.length),
      ]),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Card(child: ListTile(title: Text('Carregando dados locais...')));
        final counts = snapshot.data as List<int>;
        return Column(
          children: [
            _buildStatTile('Produtos', counts[0], Icons.shopping_cart),
            _buildStatTile('Contatos (Total)', counts[1], Icons.person_search),
            _buildStatTile('Cotações', counts[2], Icons.list_alt),
            _buildStatTile('Categorias', counts[3], Icons.category),
          ],
        );
      },
    );
  }

  Widget _buildStatTile(String label, int count, IconData icon) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF128C7E)),
        title: Text(label),
        trailing: CircleAvatar(
          backgroundColor: const Color(0xFF25D366),
          radius: 12,
          child: Text(count.toString(), style: const TextStyle(fontSize: 10, color: Colors.white)),
        ),
      ),
    );
  }
}
