import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../logic/shopping_cart.dart';
import '../../notifiers/shopping_cart_notifier.dart';

class ShoppingCartScreen extends StatelessWidget {
  final ShoppingCart shoppingCart;
  final ShoppingCartNotifier shoppingCartNotifier;
  final Map<String, dynamic> article;

  const ShoppingCartScreen({
    super.key,
    required this.shoppingCart,
    required this.shoppingCartNotifier,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    ShoppingCart shoppingCart = Provider.of<ShoppingCart>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito de Compras'),
      ),
      body: Consumer<ShoppingCartNotifier>(
        builder: (context, shoppingCartNotifier, child) {
           shoppingCart = shoppingCartNotifier.shoppingCart;
          return ListView.builder(
            itemCount: shoppingCart.selectedItems.length,
            itemBuilder: (context, index) {
              final item = shoppingCart.selectedItems[index];
              return ListTile(
                title: Text(item['descripcion'].toString()),
                subtitle: Text('Total: \$${item['prc_venta']}'),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_circle),
                  onPressed: () {
                    shoppingCartNotifier.removeFromCart(index);
                  },
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Consumer<ShoppingCartNotifier>(
        builder: (context, shoppingCartNotifier, child) {
           shoppingCart = shoppingCartNotifier.shoppingCart;
          return BottomAppBar(
            color: Colors.blueGrey,
            child: SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Costo Total: \$${shoppingCart.calculateTotalCost()}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: ElevatedButton(
  onPressed: () {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Timestamp now = Timestamp.now();

      FirebaseFirestore.instance.collection('orders').add({
        'total_cost': shoppingCart.calculateTotalCost(),
        'products': shoppingCart.selectedItems,
        'user_email': user.email,
        'status': 'Pendiente',
        'timestamp': now,
      }).then((value) {
        String orderId = 'pedido_${user.uid}_${value.id}';
        value.update({'order_id': orderId});

        // #1 Mostrar un Snackbar de pedido exitoso
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('¡Pedido realizado con éxito!'),
            backgroundColor: Colors.green, // Color verde
          ),
        );

        // #2 Deseleccionar cantidades de productos
        shoppingCartNotifier.clearCart();

        // #3 Vaciar el carrito
        shoppingCartNotifier.emptyCart();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al confirmar la compra: $error'),
            backgroundColor: Colors.red,
          ),
        );
      });
    }
  },
  child: const Text('Confirmar Compra'),
)

                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
