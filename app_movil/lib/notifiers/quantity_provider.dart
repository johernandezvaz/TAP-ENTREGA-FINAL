import 'package:flutter/material.dart';

class QuantityProvider extends ChangeNotifier {
  final Map<String, double> _quantities = {};

  Map<String, double> get quantities => _quantities;

  void updateQuantity(String article, double quantity) {
    _quantities[article] = quantity;
    notifyListeners();
  }


  void clearQuantities() {
  _quantities.forEach((article, quantity) {
    _quantities[article] = 0.0;
  });
  notifyListeners();
}


}
