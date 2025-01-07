import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:predict_anemia/constant/color_constant.dart';
import 'package:predict_anemia/constant/text_style_constant.dart';

class GoodResultWidget extends StatelessWidget {
  const GoodResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorConstant.secureColor,
              ),
              child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: FaIcon(
                    FontAwesomeIcons.check,
                    color: ColorConstant.whiteColor,
                    size: 32,
                  )),
            ),
            const SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selamat!',
                  style: TextStyleConstant.montserratBlack.copyWith(
                    color: ColorConstant.whiteColor,
                  ),
                ),
                Text(
                  'Anda tidak terindikasi Anemia',
                  style: TextStyleConstant.montserratBold.copyWith(
                    color: ColorConstant.whiteColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
