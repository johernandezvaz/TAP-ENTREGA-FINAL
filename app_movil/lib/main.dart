import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:smartmart/logic/shopping_cart.dart';
import 'package:smartmart/notifiers/quantity_provider.dart';
import 'package:smartmart/notifiers/shopping_cart_notifier.dart';
import 'package:smartmart/screens/login_screen.dart';
import 'package:smartmart/screens/home_screen.dart';
import 'package:smartmart/theme/theme_provider.dart';
import '/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Creamos una única instancia de ShoppingCart y ShoppingCartNotifier
  final ShoppingCart shoppingCart = ShoppingCart();
  final ShoppingCartNotifier shoppingCartNotifier = ShoppingCartNotifier();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeNotifier()),
        ChangeNotifierProvider(create: (context) => QuantityProvider()),
        // Pasamos las instancias únicas de ShoppingCart y ShoppingCartNotifier
        ChangeNotifierProvider.value(value: shoppingCart),
        ChangeNotifierProvider.value(value: shoppingCartNotifier),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      title: 'SmartMart',
      theme: themeNotifier.getTheme(),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
