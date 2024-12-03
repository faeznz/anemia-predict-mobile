import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:predict_anemia/constant/color_constant.dart';
import 'package:predict_anemia/constant/text_style_constant.dart';
import 'package:predict_anemia/screen/predict/scan_screen.dart';

class ButtonCameraWidget extends StatefulWidget {
  const ButtonCameraWidget({super.key});

  @override
  State<ButtonCameraWidget> createState() => _ButtonCameraWidgetState();
}

class _ButtonCameraWidgetState extends State<ButtonCameraWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ScanScreen(),
            ),
          );
        },
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
        child: FaIcon(
          FontAwesomeIcons.camera,
          color: ColorConstant.whiteColor,
        ),
      ),
    );
  }
}
