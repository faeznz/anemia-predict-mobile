import 'package:flutter/material.dart';
import 'package:predict_anemia/constant/color_constant.dart';
import 'package:predict_anemia/constant/text_style_constant.dart';

class TextFieldLoginWidget extends StatefulWidget {
  const TextFieldLoginWidget({super.key});

  @override
  State<TextFieldLoginWidget> createState() => _TextFieldLoginWidgetState();
}

class _TextFieldLoginWidgetState extends State<TextFieldLoginWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Email',
            hintStyle: TextStyleConstant.montserratNormal.copyWith(
              color: ColorConstant.secondaryColor,
              letterSpacing: 1,
              fontSize: 16,
            ),
            filled: true,
            fillColor: ColorConstant.accentColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 24),
        TextField(
          obscureText: _obscureText,
          decoration: InputDecoration(
            hintText: 'Password',
            hintStyle: TextStyleConstant.montserratNormal.copyWith(
              color: ColorConstant.secondaryColor,
              letterSpacing: 1,
              fontSize: 16,
            ),
            filled: true,
            fillColor: ColorConstant.accentColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
