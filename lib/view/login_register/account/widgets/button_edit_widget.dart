import 'package:flutter/material.dart';
import 'package:predict_anemia/constant/color_constant.dart';
import 'package:predict_anemia/constant/text_style_constant.dart';
import 'package:predict_anemia/view/welcome/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ButtonEditWidget extends StatefulWidget {
  const ButtonEditWidget({super.key});

  @override
  State<ButtonEditWidget> createState() => _ButtonEditWidgetState();
}

class _ButtonEditWidgetState extends State<ButtonEditWidget> {
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: logout,
        style: TextButton.styleFrom(
          backgroundColor: ColorConstant.accentColor,
          padding: const EdgeInsets.symmetric(
            vertical: 12,
          ),
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
          'Edit',
          style: TextStyle(
            color: ColorConstant.secondaryColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
