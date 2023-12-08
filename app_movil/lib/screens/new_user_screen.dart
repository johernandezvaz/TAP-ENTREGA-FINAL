import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:smartmart/theme/theme_provider.dart';

class NewUserScreen extends StatefulWidget {
  const NewUserScreen({super.key});

  @override
  _NewUserScreenState createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NewUserScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();


  Color getButtonColor(BuildContext context) {
  return Theme.of(context).buttonTheme.colorScheme?.primary ?? Colors.blue;
}

 Future<void> _createUser() async {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Check if username already exists in Firestore
    final usernameExists = await _checkUsernameExists(username);

    if (usernameExists) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Username $username already exists.'),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
          ),
);



      return;
    }

     final emailExists = await _checkEmailExists(email);

     if (emailExists) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email $email already exists.'),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
          ),
        );
        return;
      }


    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create a Firestore document to store user details including username
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'username': username,
        'email': email,
        // Add more user details as needed
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('New user created: $email'),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.green,
          ),
);


      // Navigate to home or another screen after successful account creation
      // Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException {
      // Handle FirebaseAuthException
      // ...
    } catch (e) {
      // Handle other exceptions
      // ...
    }
  }

  Future<bool> _checkUsernameExists(String username) async {
    final querySnapshot = await _firestore.collection('users').where('username', isEqualTo: username).get();
    return querySnapshot.docs.isNotEmpty;
  }


  Future<bool> _checkEmailExists(String email) async {
    final querySnapshot =
    await _firestore.collection('users').where('email', isEqualTo: email).get();
    return querySnapshot.docs.isNotEmpty;
}

 @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    final TextStyle selectedTextStyle = TextStyle(
      color: themeNotifier.isDarkMode ? const Color(0xF0F0F0) : const Color(0x191919),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
        backgroundColor: themeNotifier.isDarkMode ? const Color(0x191919) : const Color(0xF0F0F0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Usuario',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: themeNotifier.isDarkMode ? const Color(0xFFC84B31) : const Color(0xFF2D4263),
                  ),
                ),
              ),
              style: selectedTextStyle,
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Correo',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: themeNotifier.isDarkMode ? const Color(0xFFC84B31) : const Color(0xFF2D4263),
                  ),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              style: selectedTextStyle,
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: themeNotifier.isDarkMode ? const Color(0xFFC84B31) : const Color(0xFF2D4263),
                  ),
                ),
              ),
              obscureText: true,
              style: selectedTextStyle,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
        onPressed: () {
          // Resto de tu lógica aquí
          _createUser();
        },
        style: ElevatedButton.styleFrom(
          primary: getButtonColor(context),
          onPrimary: Colors.white,
        ),
        child: const Text('Crear Cuenta'),
      ),



          ],
        ),
      ),
    );
  }
}