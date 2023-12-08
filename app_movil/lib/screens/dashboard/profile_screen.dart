// profile_screen.dart
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:smartmart/screens/orders_screen.dart'; // Importa la pantalla de pedidos

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? username; // Nombre de usuario
  String? profileImageUrl; // URL de la imagen de perfil
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
  }

  Future<void> _fetchUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        // Obtener el nombre de usuario del perfil de Firebase Auth
        username = user.displayName ?? user.email?.split('@').first; // Obtener el nombre del correo
        _loadProfileImage(user.uid);
      });
    }
  }

  Future<void> _loadProfileImage(String userId) async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    try {
      // Obtener la URL de la imagen de perfil de Firebase Storage
      Reference ref = FirebaseStorage.instance.ref().child('profile_images').child(userId);
      String imageUrl = await ref.getDownloadURL();

      if (mounted) {
        setState(() {
          profileImageUrl = imageUrl;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error al cargar la imagen del perfil'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _changeProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        isLoading = true;
      });
      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          Reference ref = FirebaseStorage.instance.ref().child('profile_images').child(user.uid);

          // Verificar si la carpeta 'profile_images' existe
          bool exists = false;
          try {
            // Listar los elementos en la carpeta 'profile_images'
            ListResult result = await ref.listAll();
            exists = result.items.isNotEmpty;
          } catch (e) {
            // Si hay un error, asumimos que la carpeta no existe
            exists = false;
          }

          if (!exists) {
            // Si no existe, crea la carpeta 'profile_images'
            await ref.putData(Uint8List(0));
          }

          TaskSnapshot uploadTask = await ref.putFile(File(pickedFile.path));
          String imageUrl = await uploadTask.ref.getDownloadURL();

          await user.updatePhotoURL(imageUrl);

          setState(() {
            profileImageUrl = imageUrl;
            isLoading = false;
          });
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error al cargar la imagen del perfil'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart), // Icono de pedidos
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OrdersScreen()), // Navega a la pantalla de pedidos
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: profileImageUrl != null
                  ? CachedNetworkImageProvider(profileImageUrl!) as ImageProvider<Object>
                  : const AssetImage('assets/profile-user.png'),
                  ),
                if (isLoading)
                  const Positioned.fill(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Nombre de Usuario: ${username ?? "No disponible"}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _changeProfileImage,
              child: const Text('Cambiar Foto de Perfil'),
            ),
          ],
        ),
      ),
    );
  }
}
