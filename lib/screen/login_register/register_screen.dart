import 'package:flutter/material.dart';
import 'package:predict_anemia/constant/text_style_constant.dart';
import 'package:predict_anemia/screen/login_register/widgets/divider_login_widget.dart';
import 'package:predict_anemia/screen/login_register/widgets/google_button_widget.dart';
import 'package:predict_anemia/screen/login_register/widgets/text_field_register_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                    'Daftar',
                    style: TextStyleConstant.montserratBlack.copyWith(
                      fontSize: 32,
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                const TextFieldRegisterWidget(),
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
