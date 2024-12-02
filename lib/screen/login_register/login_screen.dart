import 'package:flutter/material.dart';
import 'package:predict_anemia/constant/color_constant.dart';
import 'package:predict_anemia/constant/text_style_constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:predict_anemia/screen/login_register/widgets/button_login_widget.dart';
import 'package:predict_anemia/screen/login_register/widgets/divider_login_widget.dart';
import 'package:predict_anemia/screen/login_register/widgets/google_button_widget.dart';
import 'package:predict_anemia/screen/login_register/widgets/text_field_login_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Masuk',
          style: TextStyleConstant.montserratBlack,
        ),
        leading: Center(
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const FaIcon(FontAwesomeIcons.chevronLeft),
          ),
        ),
        backgroundColor: ColorConstant.whiteColor,
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 32,
            ),
            child: Column(
              children: [
                SizedBox(height: 132),
                TextFieldLoginWidget(),
                SizedBox(height: 128),
                Column(
                  children: [
                    ButtonLoginWidget(),
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
