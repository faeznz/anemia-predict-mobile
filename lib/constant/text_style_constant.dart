import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:predict_anemia/constant/color_constant.dart';

class TextStyleConstant {
  static TextStyle interBold = GoogleFonts.inter(
    fontSize: 24,
    color: ColorConstant.primaryColor,
    fontWeight: FontWeight.bold,
  );

  static TextStyle interNormal = GoogleFonts.inter(
    fontSize: 12,
    color: ColorConstant.whiteColor,
    fontWeight: FontWeight.normal,
  );
}
