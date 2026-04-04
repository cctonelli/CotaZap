import 'package:flutter/material.dart';

class CategoryIconHelper {
  static IconData getIcon(String? iconName) {
    switch (iconName) {
      case 'settings_input_component':
        return Icons.settings_input_component;
      case 'bolt':
        return Icons.bolt;
      case 'format_paint':
        return Icons.format_paint;
      case 'tire_repair':
        return Icons.tire_repair;
      case 'water_drop':
        return Icons.water_drop;
      case 'category':
        return Icons.category;
      case 'shopping_basket':
        return Icons.shopping_basket;
      case 'inventory':
        return Icons.inventory;
      default:
        return Icons.help_outline;
    }
  }
}
