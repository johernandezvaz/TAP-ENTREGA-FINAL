import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late User? _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      body: _user != null
          ? StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('orders')
                  .where('user_email', isEqualTo: _user!.email)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error al cargar los pedidos'));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No hay pedidos disponibles'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final order = snapshot.data!.docs[index];
                      final orderData = order.data() as Map<String, dynamic>;

                      final totalCost = orderData['total_cost'] != null
                          ? '\$${orderData['total_cost']}'
                          : 'N/A';
                      final status = orderData['status'] ?? 'N/A';

                      return ListTile(
                        title: Text('Pedido #${index + 1}'),
                        subtitle: Text(
                          'Costo total: $totalCost - Estado: $status',
                        ),
                        onTap: () {
                          _showOrderDetails(context, orderData['products']);
                        },
                      );
                    },
                  );
                }
              },
            )
          : const Center(child: Text('Usuario no encontrado')),
    );
  }

  void _showOrderDetails(BuildContext context, List<dynamic>? products) {
    if (products == null || products.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No hay detalles disponibles para este pedido'),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Artículos del Pedido'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.5,
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final productInfo = products[index] as Map<String, dynamic>;

                final productName =
                    productInfo['descripcion'] ?? 'Descripción no disponible';
                final productQuantity =
                    productInfo['quantity'] ?? 'Cantidad no disponible';

                return ListTile(
                  title: Text(productName.toString()),
                  subtitle: Text('Cantidad: $productQuantity'),
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
