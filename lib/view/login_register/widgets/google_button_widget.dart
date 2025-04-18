import 'package:flutter/material.dart';
import 'package:predict_anemia/bottom_navbar.dart';
import 'package:predict_anemia/constant/color_constant.dart';
import 'package:predict_anemia/constant/text_style_constant.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleButtonWidget extends StatelessWidget {
  const GoogleButtonWidget({super.key});

  Future<void> _handleGoogleLogin(BuildContext context) async {
    try {
      final result = await FlutterWebAuth2.authenticate(
        url: 'https://api-data-predict-anamia.vercel.app/auth/google',
        callbackUrlScheme: 'myapp',
      );

      final token = Uri.parse(result).queryParameters['token'];

      if (token != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        if (!context.mounted) return;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const MyButtomNavbar()),
          (route) => false,
        );
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () => _handleGoogleLogin(context),
        style: TextButton.styleFrom(
          backgroundColor: ColorConstant.accentColor,
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
        child: const Image(
          image: AssetImage("assets/icons/icon_google.png"),
        ),
      ),
    );
  }
}
