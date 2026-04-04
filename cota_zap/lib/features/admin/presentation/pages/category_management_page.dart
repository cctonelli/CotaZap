import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cota_zap/features/suppliers/presentation/controllers/categories_controller.dart';
import 'package:cota_zap/features/admin/presentation/controllers/admin_controller.dart';
import 'package:cota_zap/drift/database.dart';

class CategoryManagementPage extends ConsumerWidget {
  const CategoryManagementPage({super.key});

  void _showCategoryForm(BuildContext context, WidgetRef ref, {ProductCategory? category}) {
    final nameController = TextEditingController(text: category?.name);
    final descController = TextEditingController(text: category?.description);
    final iconController = TextEditingController(text: category?.iconName ?? 'inventory_2');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(category == null ? 'Nova Categoria' : 'Editar Categoria'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nome da Categoria'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: iconController,
              decoration: const InputDecoration(labelText: 'Ícone (Material Icon Name)'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCELAR')),
          ElevatedButton(
            onPressed: () {
              ref.read(adminControllerProvider.notifier).upsertCategory(
                id: category?.id,
                name: nameController.text,
                description: descController.text,
                iconName: iconController.text,
              );
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
            child: const Text('SALVAR', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesState = ref.watch(categoriesControllerProvider);
    final adminController = ref.read(adminControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Categorias'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCategoryForm(context, ref),
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: categoriesState.isLoading && categoriesState.categories.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: categoriesState.categories.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final cat = categoriesState.categories[index];
                return Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigo.withOpacity(0.1),
                      child: const Icon(Icons.category, color: Colors.indigo),
                    ),
                    title: Text(cat.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(cat.description ?? 'Sem descrição'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit_outlined, color: Colors.blue),
                          onPressed: () => _showCategoryForm(context, ref, category: cat),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: () => _showDeleteConfirmation(context, adminController, cat),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, AdminController controller, ProductCategory cat) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar exclusão?'),
        content: Text('Deseja realmente excluir a categoria "${cat.name}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCELAR')),
          ElevatedButton(
            onPressed: () {
              controller.deleteCategory(cat.id);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('EXCLUIR', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
