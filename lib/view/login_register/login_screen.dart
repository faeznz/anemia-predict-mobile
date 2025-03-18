import 'package:flutter/material.dart';
import 'package:predict_anemia/constant/text_style_constant.dart';
import 'package:predict_anemia/view/login_register/widgets/divider_login_widget.dart';
import 'package:predict_anemia/view/login_register/widgets/google_button_widget.dart';
import 'package:predict_anemia/view/login_register/widgets/text_field_login_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
            ),
            child: Column(
              children: [
                const SizedBox(height: 72),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Masuk',
                    style: TextStyleConstant.montserratBlack.copyWith(
                      fontSize: 32,
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                const TextFieldLoginWidget(),
                const SizedBox(height: 24),
                const Column(
                  children: [
                    DividerLoginWidget(),
                    GoogleButtonWidget(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
