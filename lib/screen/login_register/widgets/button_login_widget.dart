import 'package:flutter/material.dart';
import 'package:predict_anemia/constant/color_constant.dart';
import 'package:predict_anemia/constant/text_style_constant.dart';

class ButtonLoginWidget extends StatefulWidget {
  const ButtonLoginWidget({super.key});

  @override
  State<ButtonLoginWidget> createState() => _ButtonLoginWidgetState();
}

class _ButtonLoginWidgetState extends State<ButtonLoginWidget> {
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
          'Masuk',
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
