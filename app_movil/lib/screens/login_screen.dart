// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartmart/screens/new_user_screen.dart';
import 'package:provider/provider.dart';
import 'package:smartmart/theme/theme_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    final TextStyle selectedTextStyle = TextStyle(
      color: themeNotifier.getTheme().textTheme.bodyLarge?.color ?? Colors.black,
    );

    final TextStyle unselectedTextStyle = TextStyle(
      color: themeNotifier.getTheme().textTheme.bodyLarge?.color ?? Colors.grey,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeNotifier.getTheme().appBarTheme.backgroundColor ?? Colors.blue,
        title: const Text('Inicio de Sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF2D4263),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF34B3F1),
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF2D4263),
                  ),
                ),
                fillColor: themeNotifier.getTheme().scaffoldBackgroundColor,
                filled: true,
              ),
              keyboardType: TextInputType.emailAddress,
              style: emailController.text.isEmpty ? unselectedTextStyle : selectedTextStyle,
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF2D4263),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF34B3F1),
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF2D4263),
                  ),
                ),
                fillColor: themeNotifier.getTheme().scaffoldBackgroundColor,
                filled: true,
              ),
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              style: passwordController.text.isEmpty ? unselectedTextStyle : selectedTextStyle,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                final email = emailController.text;
                final password = passwordController.text;
                try {
                  final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  if (userCredential.user != null) {
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                } on FirebaseAuthException catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: const Text('Credenciales inválidas, favor de verificar'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  print('Error: ${e.message}');
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: themeNotifier.getTheme().textTheme.bodyLarge?.color ?? Colors.white, backgroundColor: themeNotifier.getTheme().buttonTheme.colorScheme?.primary ?? Colors.blue,
              ),
              child: const Text('Iniciar Sesión'),
            ),
            const SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewUserScreen()),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: themeNotifier.getTheme().buttonTheme.colorScheme?.primary ?? Colors.blue,
              ),
              child: const Text('Crear Cuenta'),
            ),
          ],
        ),
      ),
    );
  }
}
