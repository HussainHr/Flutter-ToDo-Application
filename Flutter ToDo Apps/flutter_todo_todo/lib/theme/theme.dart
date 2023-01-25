import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluisClr = Color(0xFF4e4ae8);
const Color yelloClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFff4667);
const Color whiteClr = Colors.white;
const Color primaryClr = bluisClr;
const Color darkGrayClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static final light = ThemeData(
    backgroundColor: Colors.white,
    primaryColor: bluisClr,
    brightness: Brightness.light,
  );
  static final dark = ThemeData(
    backgroundColor: darkGrayClr,
    primaryColor: darkGrayClr,
    brightness: Brightness.dark,
  );
}

// this method for textStyle
TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Colors.grey[400] : Colors.grey,
  ));
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Colors.white : Colors.black,
  ));
}

TextStyle get buttonStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ));
}

TextStyle get bottomButtonStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Colors.white : Colors.black,
  ));
}

TextStyle get textFormnStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[600],
  ));
}
