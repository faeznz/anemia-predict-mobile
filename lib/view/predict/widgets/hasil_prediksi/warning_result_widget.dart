import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:predict_anemia/constant/color_constant.dart';
import 'package:predict_anemia/constant/text_style_constant.dart';

class WarningResultWidget extends StatelessWidget {
  const WarningResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorConstant.warningColor,
              ),
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: FaIcon(
                    FontAwesomeIcons.exclamation,
                    color: ColorConstant.whiteColor,
                    size: 32,
                  )),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Anda terindikasi Anemia',
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
