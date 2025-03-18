import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:predict_anemia/constant/color_constant.dart';
import 'package:predict_anemia/constant/text_style_constant.dart';

class HeadingHomeWidget extends StatefulWidget {
  const HeadingHomeWidget({super.key});

  @override
  State<HeadingHomeWidget> createState() => _HeadingHomeWidgetState();
}

class _HeadingHomeWidgetState extends State<HeadingHomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Selamat Datang !',
              style: TextStyleConstant.montserratBold.copyWith(
                fontSize: 18,
              ),
            ),
            // FaIcon(
            //   FontAwesomeIcons.user,
            //   color: ColorConstant.primaryColor,
            //   size: 20,
            // ),
          ],
        ),
        const SizedBox(height: 24),
        RichText(
          text: TextSpan(
            text: 'Ketahui kondisi kamu lewat aplikasi ini\n',
            style: TextStyleConstant.montserratBold.copyWith(
              color: ColorConstant.secondaryColor,
              fontSize: 24,
              height: 1.2,
            ),
            children: [
              TextSpan(
                text: 'Scan telapak tangan kamu untuk mengetahui hasilnya',
                style: TextStyleConstant.montserratNormal.copyWith(
                  color: ColorConstant.secondaryColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
