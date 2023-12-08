import 'package:flutter/material.dart';
import 'package:smartmart/logic/shopping_cart.dart';

class ShoppingCartNotifier with ChangeNotifier {
  final ShoppingCart _shoppingCart = ShoppingCart();

  ShoppingCart get shoppingCart => _shoppingCart;

  void addToCart(Map<String, dynamic> item) {
    _shoppingCart.addItem(item);
    notifyListeners();
  }

  void removeFromCart(int index) {
    _shoppingCart.removeItem(index);
    notifyListeners();
  }

  // Método para deseleccionar todas las cantidades de productos
  void clearCart() {
    _shoppingCart.clearQuantities(); // Implementa este método en tu clase ShoppingCart
    notifyListeners();
  }

  // Método para vaciar completamente el carrito
  void emptyCart() {
    _shoppingCart.emptyCart(); // Implementa este método en tu clase ShoppingCart
    notifyListeners();
  }

  // Otros métodos y propiedades que puedas necesitar...
}


