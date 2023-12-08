import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  final lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: const Color(0xFFF0F0F0),
    appBarTheme: const AppBarTheme(
      color: Color(0xFFF45050),
      iconTheme: IconThemeData(color: Colors.white), // Iconos en el app bar
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xFF3C486B),
      textTheme: ButtonTextTheme.normal,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black), // Ajustar según necesidades
      bodyMedium: TextStyle(color: Colors.black), // Ajustar según necesidades
    ),
  );

  final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: const Color(0xFF191919),
    appBarTheme: const AppBarTheme(
      color: Color(0xFFC84B31),
      iconTheme: IconThemeData(color: Colors.white), // Iconos en el app bar
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xFF2D4263),
      textTheme: ButtonTextTheme.normal,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white), // Ajustar según necesidades
      bodyMedium: TextStyle(color: Colors.white), // Ajustar según necesidades
    ),
  );

  ThemeNotifier() {
    _loadThemeFromPrefs();
  }

  void _loadThemeFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }

  void toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
  }

  ThemeData getTheme() {
    return _isDarkMode ? darkTheme : lightTheme;
  }
}
