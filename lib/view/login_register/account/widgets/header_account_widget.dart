import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:predict_anemia/constant/color_constant.dart';
import 'package:predict_anemia/constant/text_style_constant.dart';

class HeaderAccountWidget extends StatefulWidget {
  const HeaderAccountWidget({super.key});

  @override
  State<HeaderAccountWidget> createState() => _HeaderAccountWidgetState();
}

class _HeaderAccountWidgetState extends State<HeaderAccountWidget> {
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
                  Navigator.pop(context);
                },
                child: FaIcon(
                  FontAwesomeIcons.chevronLeft,
                  color: ColorConstant.primaryColor,
                ),
              ),
              Text(
                'Akun Profil',
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
