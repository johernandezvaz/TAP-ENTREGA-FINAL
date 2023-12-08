import 'package:flutter/material.dart';

class ShoppingCart extends ChangeNotifier {
  List<Map<String, dynamic>> selectedItems = [];

  void addItem(Map<String, dynamic> item) {
    selectedItems.add(item);
    notifyListeners();
  }

  void removeItem(int index) {
    selectedItems.removeAt(index);
    notifyListeners();
  }

  double calculateTotalCost() {
    double total = 0;
    for (final item in selectedItems) {
      total += (item['prc_venta'] as double); // Asumiendo que 'prc_venta' es el precio del artículo
    }
    return total;
  }

  // Método para deseleccionar todas las cantidades de productos
  void clearQuantities() {
    // Iterar sobre los elementos y establecer la cantidad a 0 o null según el tipo de dato
    for (final item in selectedItems) {
      item['quantity'] = item['quantity'] is int ? 0 : null;
    }
    notifyListeners();
  }

  // Método para vaciar completamente el carrito
  void emptyCart() {
    selectedItems.clear();
    notifyListeners();
  }
}


