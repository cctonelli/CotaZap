import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cota_zap/features/admin/presentation/controllers/units_of_measure_controller.dart';
import 'package:cota_zap/drift/database.dart';

class UnitOfMeasureManagementPage extends ConsumerWidget {
  const UnitOfMeasureManagementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unitsState = ref.watch(unitsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Unidades de Medida'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: unitsState.isLoading && unitsState.units.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: unitsState.units.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final unit = unitsState.units[index];
                return Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigo.withOpacity(0.1),
                      child: Text(unit.code, style: const TextStyle(color: Colors.indigo, fontSize: 12)),
                    ),
                    title: Text(unit.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${unit.description ?? "-"} (${unit.category ?? "-"})'),
                  ),
                );
              },
            ),
    );
  }
}
