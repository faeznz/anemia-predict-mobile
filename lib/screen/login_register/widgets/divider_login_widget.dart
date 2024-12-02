import 'package:flutter/material.dart';
import 'package:predict_anemia/constant/color_constant.dart';
import 'package:predict_anemia/constant/text_style_constant.dart';

class DividerLoginWidget extends StatelessWidget {
  const DividerLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 56,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Divider(
              thickness: 2,
              color: ColorConstant.accentColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Text(
              'Atau lanjutkan dengan',
              style: TextStyleConstant.montserratSemibold.copyWith(
                color: ColorConstant.secondaryColor,
                fontSize: 12,
                letterSpacing: 1,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              thickness: 2,
              color: ColorConstant.accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
