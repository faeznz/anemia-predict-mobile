import 'package:flutter/material.dart';
import 'package:predict_anemia/constant/color_constant.dart';
import 'package:predict_anemia/constant/text_style_constant.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Text(
                  'AnemiaPredict',
                  style: TextStyleConstant.montserratBlack,
                ),
                Text(
                  'Versi 1.0.0',
                  style: TextStyleConstant.montserratNormal.copyWith(
                    color: ColorConstant.primaryColor,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorConstant.primaryColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tentang',
                          style: TextStyleConstant.montserratBlack.copyWith(
                            color: ColorConstant.whiteColor,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Perkembangan teknologi AI dan machine learning memungkinkan deteksi dini anemia secara non-invasif melalui analisis citra telapak tangan menggunakan perangkat mobile. Metode ini lebih efisien dan mudah diakses daripada metode konvensional, terutama di daerah dengan keterbatasan layanan kesehatan. Deep learning, khususnya CNN, efektif untuk ekstraksi fitur dari gambar telapak tangan, dan dikombinasikan dengan algoritma machine learning seperti k-NN, Naïve Bayes, SVM, dan Decision Tree, serta teknik ensemble learning, dapat menghasilkan model prediksi anemia dengan akurasi tinggi. Implementasi pada perangkat mobile dengan TensorFlow Lite memungkinkan deteksi real-time,  aksesibilitas tinggi, dan penggunaan offline, sehingga  berpotensi meningkatkan kualitas hidup dan kesadaran masyarakat terhadap anemia.',
                          style: TextStyleConstant.montserratNormal,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
