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
            padding: const EdgeInsets.symmetric(vertical: 52),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'AnemiaPredict',
                    style: TextStyleConstant.montserratBold,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 48,
                          vertical: 56,
                        ),
                        child: RichText(
                          text: TextSpan(
                            text: 'Selamat\n',
                            style: TextStyleConstant.montserratBlack.copyWith(
                              fontSize: 40,
                              height: 1.0,
                            ),
                            children: [
                              TextSpan(
                                text: 'Datang!',
                                style:
                                    TextStyleConstant.montserratBlack.copyWith(
                                  fontSize: 56,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 16,
                            ),
                            child: Row(
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
                                    style: TextStyleConstant.montserratBold
                                        .copyWith(
                                      fontSize: 16,
                                      letterSpacing: 1,
                                      color: ColorConstant.whiteColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
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
                                    style: TextStyleConstant.montserratBold
                                        .copyWith(
                                      fontSize: 16,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 24,
                            ),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Skip >>',
                                style:
                                    TextStyleConstant.montserratBold.copyWith(
                                  fontSize: 14,
                                  color: ColorConstant.primaryColor,
                                ),
                              ),
                            ),
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
