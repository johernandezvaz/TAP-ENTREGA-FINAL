import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PasswordChangeScreen extends StatelessWidget {
  PasswordChangeScreen({super.key});

  final TextEditingController newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cambiar Contraseña'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20), // Agrega espacio entre el AppBar y el primer TextFormField
            TextFormField(
              decoration: const InputDecoration(labelText: 'Contraseña Actual'),
              obscureText: true,
              // Implementa la lógica para obtener la contraseña actual
            ),
            const SizedBox(height: 20), // Agrega espacio entre los campos de texto
            TextFormField(
              decoration: const InputDecoration(labelText: 'Nueva Contraseña'),
              obscureText: true,
              // Implementa la lógica para obtener la nueva contraseña
            ),
            const SizedBox(height: 20), // Agrega espacio entre los campos de texto
            TextFormField(
              controller: newPasswordController,
              decoration: const InputDecoration(labelText: 'Confirmar Nueva Contraseña'),
              obscureText: true,
              // Implementa la lógica para confirmar la nueva contraseña
            ),
            const SizedBox(height: 30), // Agrega más espacio entre el último campo y el botón
            ElevatedButton(
              onPressed: () async {
                String newPassword = newPasswordController.text; // Obtener el valor del nuevo password del TextFormField
                try {
                  User? user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    await user.updatePassword(newPassword);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Contraseña actualizada exitosamente'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    // Redirige a la pantalla de Settings una vez que se actualice la contraseña
                    Navigator.pop(context);
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error al cambiar la contraseña: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0), // Ajusta los valores según sea necesario
              ),
              child: const Text('Cambiar Contraseña'),
            ),
          ],
        ),
      ),
    );
  }
}
