import 'package:flutter/material.dart';
import 'package:predict_anemia/view/predict/widgets/card_pick_image_widget.dart';
import 'package:predict_anemia/view/predict/widgets/header_pick_image_widget.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});
  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              HeaderPickImageWidget(),
              CardPickImageWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
