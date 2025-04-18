import 'dart:async';
import 'package:flutter/material.dart';
import 'package:predict_anemia/bottom_navbar.dart';
import 'package:predict_anemia/constant/color_constant.dart';
import 'package:predict_anemia/constant/text_style_constant.dart';
import 'package:predict_anemia/view/welcome/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      _checkTokenAndNavigate();
    });
  }

  Future<void> _checkTokenAndNavigate() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (!mounted) return;

    if (token != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyButtomNavbar()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: ColorConstant.primaryColor,
          image: const DecorationImage(
            image: AssetImage('assets/images/doc_1.png'),
            fit: BoxFit.contain,
            alignment: Alignment(0, 1),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 80,
                  horizontal: 40,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Anemia\n',
                          style: TextStyleConstant.montserratBlack.copyWith(
                            color: ColorConstant.whiteColor,
                            fontSize: 56,
                            height: 1.0,
                          ),
                          children: [
                            TextSpan(
                              text: 'Predict!',
                              style: TextStyleConstant.montserratBlack.copyWith(
                                color: ColorConstant.whiteColor,
                                fontSize: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Ketahui anemia lewat telapak tangan kamu!',
                        style: TextStyleConstant.montserratNormal.copyWith(
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
