import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_one_life/default/colors.dart';

class ThemeDatas{
  static ThemeData themeData(){
    return ThemeData(
      backgroundColor: backgroundColor,
      fontFamily: GoogleFonts.poppins().fontFamily,
      primarySwatch: Colors.blue,
      appBarTheme: AppBarTheme(elevation: 0),
    );
  }
}

