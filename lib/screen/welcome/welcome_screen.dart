import 'package:flutter/material.dart';
import 'package:predict_anemia/constant/color_constant.dart';
import 'package:predict_anemia/constant/text_style_constant.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/images/doc_2.png"),
            fit: BoxFit.cover,
            alignment: Alignment(-300 / MediaQuery.of(context).size.width, 0),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'AnemiaPredict',
                    style: TextStyleConstant.interBold,
                  ),
                  Column(
                    children: [
                      Column(
                        children: [
                          Text(
                            'Selamat',
                            style: TextStyleConstant.interBold,
                          ),
                          Text(
                            'Datang !',
                            style: TextStyleConstant.interBold,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                    ColorConstant.primaryColor,
                                  ),
                                  fixedSize: WidgetStateProperty.all<Size>(
                                    const Size(100, 40),
                                  ),
                                ),
                                child: Text(
                                  'Masuk',
                                  style: TextStyleConstant.interNormal.copyWith(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                    ColorConstant.accentColor,
                                  ),
                                  fixedSize: WidgetStateProperty.all<Size>(
                                    const Size(100, 40),
                                  ),
                                ),
                                child: Text(
                                  'Daftar',
                                  style: TextStyleConstant.interNormal.copyWith(
                                    color: ColorConstant.primaryColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text('Daftar'),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
