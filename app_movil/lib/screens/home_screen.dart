import 'package:flutter/material.dart';
import 'package:smartmart/logic/shopping_cart.dart';
import 'package:smartmart/notifiers/shopping_cart_notifier.dart';
import 'package:smartmart/screens/dashboard/article_screen.dart';
import 'package:smartmart/screens/dashboard/profile_screen.dart';
import 'package:smartmart/screens/dashboard/settings_screen.dart';
import 'package:smartmart/screens/dashboard/shopping_cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = <Widget>[
    const ProfileScreen(),
    ArticleScreen(
      shoppingCart: ShoppingCart(),
      shoppingCartNotifier: ShoppingCartNotifier(),
    ),
     ShoppingCartScreen(
    shoppingCart: ShoppingCart(), // Proporciona un objeto ShoppingCart
    shoppingCartNotifier: ShoppingCartNotifier(), // Proporciona un objeto ShoppingCartNotifier
    article: const {}, // Proporciona un mapa vacío u algún otro valor de artículo requerido
  ),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SmartMart'),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Artículos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Carrito de Compras',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuración',
          ),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
