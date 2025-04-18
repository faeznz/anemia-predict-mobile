import 'package:flutter/material.dart';
import 'package:predict_anemia/bottom_navbar.dart';
import 'package:predict_anemia/constant/color_constant.dart';
import 'package:predict_anemia/constant/text_style_constant.dart';

class ButtonResultWidget extends StatelessWidget {
  const ButtonResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const MyButtomNavbar()),
            (route) => false,
          );
        },
        style: TextButton.styleFrom(
          backgroundColor: ColorConstant.primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 12),
          textStyle: TextStyleConstant.montserratNormal.copyWith(
            color: ColorConstant.secondaryColor,
            letterSpacing: 1,
            fontSize: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'Back To Home',
          style: TextStyle(
            color: ColorConstant.whiteColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
