import 'package:flutter/material.dart';
import 'package:predict_anemia/constant/color_constant.dart';
import 'package:predict_anemia/constant/text_style_constant.dart';

class ButtonRegisterWidget extends StatefulWidget {
  const ButtonRegisterWidget({super.key});

  @override
  State<ButtonRegisterWidget> createState() => _ButtonRegisterWidgetState();
}

class _ButtonRegisterWidgetState extends State<ButtonRegisterWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          backgroundColor: ColorConstant.primaryColor,
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
          'Daftar',
          style: TextStyleConstant.montserratNormal.copyWith(
            color: ColorConstant.whiteColor,
            fontSize: 20,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
