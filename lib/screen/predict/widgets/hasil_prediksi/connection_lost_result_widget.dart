import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:predict_anemia/constant/color_constant.dart';
import 'package:predict_anemia/constant/text_style_constant.dart';

class ConnectionLostResultWidget extends StatelessWidget {
  const ConnectionLostResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorConstant.warningColor,
          ),
          child: Padding(
              padding: const EdgeInsets.all(14),
              child: FaIcon(
                FontAwesomeIcons.linkSlash,
                color: ColorConstant.whiteColor,
                size: 24,
              )),
        ),
        const SizedBox(height: 16),
        Text(
          'Connection Lost!',
          style: TextStyleConstant.montserratBlack.copyWith(
            color: ColorConstant.whiteColor,
          ),
        ),
        Text(
          'Coba ulangi dan periksa koneksi anda',
          style: TextStyleConstant.montserratBold.copyWith(
            color: ColorConstant.whiteColor,
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
