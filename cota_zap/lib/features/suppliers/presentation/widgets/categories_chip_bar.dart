import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cota_zap/features/suppliers/presentation/controllers/categories_controller.dart';
import 'package:cota_zap/core/utils/category_icon_helper.dart';

class CategoriesChipBar extends ConsumerWidget {
  const CategoriesChipBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(categoriesControllerProvider);
    final controller = ref.read(categoriesControllerProvider.notifier);

    if (state.isLoading) {
      return const SizedBox(
        height: 50,
        child: Center(child: LinearProgressIndicator()),
      );
    }

    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: state.categories.length + 1, // +1 for "Todos"
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          if (index == 0) {
            // Option "Todos"
            final isSelected = state.selectedCategoryId == null;
            return ChoiceChip(
              label: const Text('Todos'),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) controller.selectCategory(null);
              },
              backgroundColor: Colors.white,
              selectedColor: const Color(0xFF128C7E).withOpacity(0.1),
              labelStyle: TextStyle(
                color: isSelected ? const Color(0xFF128C7E) : Colors.black87,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            );
          }

          final category = state.categories[index - 1];
          final isSelected = state.selectedCategoryId == category.id;

          return ChoiceChip(
            avatar: Icon(
              CategoryIconHelper.getIcon(category.iconName),
              size: 20,
              color: isSelected ? const Color(0xFF128C7E) : Colors.grey,
            ),
            label: Text(category.name),
            selected: isSelected,
            onSelected: (selected) {
              if (selected) controller.selectCategory(category.id);
            },
            backgroundColor: Colors.white,
            selectedColor: const Color(0xFF128C7E).withOpacity(0.1),
            labelStyle: TextStyle(
              color: isSelected ? const Color(0xFF128C7E) : Colors.black87,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          );
        },
      ),
    );
  }
}
