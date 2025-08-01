import 'package:flutter/material.dart';
import 'package:predict_anemia/view/home/widgets/button_camera_widget.dart';
import 'package:predict_anemia/view/home/widgets/heading_home_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              const HeadingHomeWidget(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/doc_3.png'),
                  ],
                ),
              ),
              const ButtonCameraWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
