import 'package:flutter/material.dart';
import 'package:predict_anemia/constant/text_style_constant.dart';
import 'package:predict_anemia/view/welcome/widgets/welcome_widget.dart';

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
                    style: TextStyleConstant.montserratBlack,
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
                      const WelcomeWidget(),
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
