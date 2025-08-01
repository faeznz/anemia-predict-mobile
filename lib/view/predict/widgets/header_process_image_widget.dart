import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:predict_anemia/bottom_navbar.dart';
import 'package:predict_anemia/constant/color_constant.dart';
import 'package:predict_anemia/constant/text_style_constant.dart';

class HeaderProcessImageWidget extends StatelessWidget {
  const HeaderProcessImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Container(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyButtomNavbar(),
                      ),
                      (route) => false);
                },
                child: FaIcon(
                  FontAwesomeIcons.chevronLeft,
                  color: ColorConstant.primaryColor,
                ),
              ),
              Text(
                'Hasil Prediksi',
                style: TextStyleConstant.montserratBlack.copyWith(
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
