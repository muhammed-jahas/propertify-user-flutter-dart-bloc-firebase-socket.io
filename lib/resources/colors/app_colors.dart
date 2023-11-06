import 'package:flutter/material.dart';

class AppColors {
  static const int _primaryValue = 0xFF1D6AEF;

  static const MaterialColor primaryColor = const MaterialColor(
    _primaryValue,
    const <int, Color>{
      50: Color(0xFFE4F1FF),
      100: Color(0xFFC7E1FF),
      200: Color(0xFFA5C8FF),
      300: Color(0xFF83ADFF),
      400: Color(0xFF6597FF),
      500: Color(_primaryValue),
      600: Color(0xFF1457D3),
      700: Color(0xFF0F4EC0),
      800: Color(0xFF0A449D),
      900: Color(0xFF033580),
    },
  );

  static const Color alertColor = Color(0xFFE01B1B);
  static const Color secondaryColor = Color(0xFF121826);
  static const Color yellowColor = Color(0xFFDBFF00);
  // static const Color accentColor = Color(0xFF9C27B0);
  // static const Color textColor = Color(0xFF333333);
  static const Color blackColor = Color(0xff000000);
}

