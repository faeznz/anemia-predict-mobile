import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:predict_anemia/constant/color_constant.dart';

class TextStyleConstant {
  static TextStyle montserratBlack = GoogleFonts.montserrat(
    fontSize: 24,
    color: ColorConstant.primaryColor,
    fontWeight: FontWeight.w900,
  );

  static TextStyle montserratBold = GoogleFonts.montserrat(
    fontSize: 24,
    color: ColorConstant.primaryColor,
    fontWeight: FontWeight.bold,
  );

  static TextStyle montserratSemibold = GoogleFonts.montserrat(
    fontSize: 24,
    color: ColorConstant.primaryColor,
    fontWeight: FontWeight.w300,
  );

  static TextStyle montserratNormal = GoogleFonts.montserrat(
    fontSize: 12,
    color: ColorConstant.whiteColor,
    fontWeight: FontWeight.normal,
  );
}
