import 'package:flutter/material.dart';
import 'package:predict_anemia/bottom_navbar.dart';
import 'package:predict_anemia/constant/color_constant.dart';
import 'package:predict_anemia/constant/text_style_constant.dart';
import 'package:predict_anemia/view/login_register/login_screen.dart';
import 'package:predict_anemia/view/login_register/register_screen.dart';

class WelcomeWidget extends StatefulWidget {
  const WelcomeWidget({super.key});

  @override
  State<WelcomeWidget> createState() => _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    ColorConstant.primaryColor,
                  ),
                  fixedSize: WidgetStateProperty.all<Size>(
                    const Size(100, 40),
                  ),
                ),
                child: Text(
                  'Masuk',
                  style: TextStyleConstant.montserratBold.copyWith(
                    fontSize: 16,
                    letterSpacing: 1,
                    color: ColorConstant.whiteColor,
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    ColorConstant.accentColor,
                  ),
                  fixedSize: WidgetStateProperty.all<Size>(
                    const Size(100, 40),
                  ),
                ),
                child: Text(
                  'Daftar',
                  style: TextStyleConstant.montserratBold.copyWith(
                    fontSize: 16,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 24,
          ),
          child: TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyButtomNavbar(),
                ),
              );
            },
            child: Text(
              'Skip >>',
              style: TextStyleConstant.montserratBold.copyWith(
                fontSize: 14,
                color: ColorConstant.primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
