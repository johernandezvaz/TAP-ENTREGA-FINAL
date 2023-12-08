import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartmart/screens/password_change_screen.dart';
import 'package:smartmart/theme/theme_provider.dart';



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(),
      child: const MaterialApp(
        title: 'Mi App',
        home: SettingsScreen(),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Tema'),
            subtitle: Text(themeNotifier.isDarkMode ? 'Modo Nocturno' : 'Modo Claro'),
            onTap: () {
              themeNotifier.toggleTheme();
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Cerrar Sesión'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login', // Ruta de la pantalla de inicio de sesión
                (route) => false, // Elimina todas las rutas anteriores
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Cambiar Contraseña'),
            subtitle: const Text('Seguridad'),
             onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  PasswordChangeScreen()),
    );
  },
          ),
        ],
      ),
    );
  }
}
