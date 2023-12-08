import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:smartmart/notifiers/quantity_provider.dart';
import 'package:smartmart/logic/shopping_cart.dart';
import 'package:smartmart/notifiers/shopping_cart_notifier.dart';

class ArticleScreen extends StatefulWidget {
  final ShoppingCart shoppingCart;

  const ArticleScreen({super.key, required this.shoppingCart, required ShoppingCartNotifier shoppingCartNotifier});

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}


class _ArticleScreenState extends State<ArticleScreen> {
  final CollectionReference _storageCollection =
      FirebaseFirestore.instance.collection('storage');

  Map<String, dynamic>? selectedArticle;
  List<Map<String, dynamic>> articles = [];

  @override
  void initState() {
    super.initState();
    _fetchArticlesFromFirestore();
  }

  Future<void> _fetchArticlesFromFirestore() async {
    QuerySnapshot querySnapshot = await _storageCollection.get();
    List<Map<String, dynamic>> fetchedArticles = [];

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      double price = data['precio'] is int
          ? (data['precio'] as int).toDouble()
          : data['precio'] as double;

      data['precio'] = price;

      fetchedArticles.add(data);
    }

    setState(() {
      articles = fetchedArticles;
    });
  }

  List<DataRow> _buildDataRows(
      List<Map<String, dynamic>> articles, QuantityProvider quantityProvider) {
    return articles.map((articleData) {
      bool isSelected =
          selectedArticle != null && selectedArticle! == articleData;
      double quantity =
          quantityProvider.quantities[articleData['article']] ?? 0.0;

      double price = double.parse(articleData['precio'].toString());

      return DataRow(
        selected: isSelected,
        cells: [
          DataCell(Text(articleData['article'])),
          DataCell(Text('\$${price.toStringAsFixed(2)}')),
          DataCell(
            Row(
              children: [
                IconButton(
                  onPressed: () =>
                      _decreaseQuantity(articleData, quantityProvider),
                  icon: const Icon(Icons.remove),
                  iconSize: 20,
                  splashRadius: 20,
                ),
                Text('$quantity'),
                IconButton(
                  onPressed: () =>
                      _increaseQuantity(articleData, quantityProvider),
                  icon: const Icon(Icons.add),
                  iconSize: 20,
                  splashRadius: 20,
                ),
              ],
            ),
          ),
        ],
      );
    }).toList();
  }

  void _increaseQuantity(
      Map<String, dynamic> articleData, QuantityProvider quantityProvider) {
    double currentQuantity =
        quantityProvider.quantities[articleData['article']] ?? 0.0;

    quantityProvider.updateQuantity(
        articleData['article'], currentQuantity + 1.0);
    setState(() {
      selectedArticle = articleData;
    });
  }

  void _decreaseQuantity(
      Map<String, dynamic> articleData, QuantityProvider quantityProvider) {
    double currentQuantity =
        quantityProvider.quantities[articleData['article']] ?? 0.0;

    if (currentQuantity > 0.0) {
      quantityProvider.updateQuantity(
          articleData['article'], currentQuantity - 1.0);
      setState(() {
        if (currentQuantity == 1.0) {
          selectedArticle = null;
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('No se pueden agregar cantidades negativas'),
        ),
      );
    }
  }

  void _addToCartAll(BuildContext context) {
  QuantityProvider quantityProvider =
      Provider.of<QuantityProvider>(context, listen: false);
  List<Map<String, dynamic>> selectedArticles = [];

  for (Map<String, dynamic> articleData in articles) {
    double quantity =
        quantityProvider.quantities[articleData['article']] ?? 0.0;

    if (quantity > 0.0) {
      selectedArticles.add(articleData);
    }
  }


  if (selectedArticles.isNotEmpty) {
    final ShoppingCartNotifier shoppingCartNotifier =
        Provider.of<ShoppingCartNotifier>(context, listen: false);

    for (Map<String, dynamic> articleData in selectedArticles) {
      final double quantity =
          quantityProvider.quantities[articleData['article']] ?? 0.0;
      final double price = articleData['precio'] as double;
      final double totalPrice = price * quantity;

      shoppingCartNotifier.addToCart({
        'descripcion': articleData['article'],
        'prc_venta': totalPrice,
        'quantity': quantity,
      });
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Artículos agregados al carrito'),
      ),
    );

    quantityProvider.clearQuantities();
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.red,
        content: Text('No hay artículos seleccionados para agregar al carrito'),
      ),
    );
  }
}


 @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ShoppingCart()),
        ChangeNotifierProvider(create: (context) => ShoppingCartNotifier()),
        // No se crea una nueva instancia de QuantityProvider aquí
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Artículos'),
        ),
        body: SingleChildScrollView(
          child: Consumer<QuantityProvider>(
            builder: (context, quantityProvider, child) {
              return DataTable(
                columns: const [
                  DataColumn(label: Text('Artículo')),
                  DataColumn(label: Text('Precio')),
                  DataColumn(label: Text('Cantidad')),
                ],
                rows: _buildDataRows(articles, quantityProvider),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _addToCartAll(context),
          tooltip: 'Agregar todos al carrito',
          child: const Icon(Icons.add_shopping_cart),
        ),
      ),
    );
  }
}