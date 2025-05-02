import 'package:flutter/material.dart';
import 'package:predict_anemia/bottom_navbar.dart';
import 'package:predict_anemia/constant/color_constant.dart';
import 'package:predict_anemia/constant/text_style_constant.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class GoogleButtonWidget extends StatelessWidget {
  const GoogleButtonWidget({super.key});

  Future<void> _handleGoogleLogin(BuildContext context) async {
    try {
      await dotenv.load();
      final baseUrl = dotenv.get('BASE_URL');
      final url = '$baseUrl/auth/google';

      final result = await FlutterWebAuth2.authenticate(
        url: url,
        callbackUrlScheme: 'myapp',
      );

      final uri = Uri.parse(result);
      final token = uri.queryParameters['token'];
      final userJsonEncoded = uri.queryParameters['user'];

      if (token != null && userJsonEncoded != null) {
        final userJson = Uri.decodeComponent(userJsonEncoded);
        final userMap = jsonDecode(userJson);

        final avatarUrl = userMap['avatarUrl'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        if (avatarUrl != null) {
          await prefs.setString('avatarUrl', avatarUrl);
        }

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
