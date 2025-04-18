import 'package:flutter/material.dart';
import 'package:predict_anemia/constant/color_constant.dart';
import 'package:predict_anemia/constant/text_style_constant.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                    'Versi 1.1.0',
                    style: TextStyleConstant.montserratNormal.copyWith(
                      color: ColorConstant.primaryColor,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tentang Aplikasi',
                          style: TextStyleConstant.montserratBlack.copyWith(
                            color: ColorConstant.secondaryColor,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Perkembangan teknologi AI dan machine learning memungkinkan deteksi dini anemia secara non-invasif melalui analisis citra telapak tangan menggunakan perangkat mobile. Deteksi ini dimungkinkan karena telapak tangan mengandung pembuluh darah kapiler yang dapat mencerminkan tingkat hemoglobin dalam darah. Perubahan warna atau pola pada telapak tangan dapat menjadi indikator visual dari kadar hemoglobin yang rendah, salah satu ciri utama anemia. Metode ini lebih efisien dan mudah diakses dibandingkan metode konvensional seperti pemeriksaan darah, terutama di daerah dengan keterbatasan layanan kesehatan. Implementasi teknologi ini pada perangkat mobile memungkinkan deteksi real-time, aksesibilitas tinggi, dan penggunaan secara offline, sehingga berpotensi meningkatkan kesadaran dan kualitas hidup masyarakat terkait kondisi anemia.',
                          style: TextStyleConstant.montserratNormal.copyWith(
                            color: ColorConstant.secondaryColor,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Model Machine Learning',
                          style: TextStyleConstant.montserratBlack.copyWith(
                            color: ColorConstant.secondaryColor,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Model ini menggunakan metode Convolutional Neural Network (CNN) untuk mengekstraksi fitur visual dari citra telapak tangan yang berkaitan dengan ciri-ciri anemia, seperti perubahan warna akibat rendahnya kadar hemoglobin. Fitur-fitur ini kemudian dianalisis menggunakan berbagai algoritma machine learning seperti k-Nearest Neighbors (k-NN), Naïve Bayes, Support Vector Machine (SVM), dan Decision Tree. Untuk meningkatkan akurasi prediksi, model juga mengadopsi teknik ensemble learning yang menggabungkan kekuatan dari beberapa algoritma. \n \n Dataset yang digunakan dalam pengembangan model ini berasal dari penelitian oleh Asare, Justice Williams; Appiahene, Peter; dan Donkoh, Emmanuel (2022), berjudul "Anemia Detection using Palpable Palm Image Datasets from Ghana", yang tersedia melalui Mendeley Data (V1), dengan DOI: 10.17632/ccr8cm22vz.1. Dataset ini terdiri dari citra telapak tangan masyarakat Ghana yang digunakan sebagai dasar pelatihan dan evaluasi model deteksi anemia secara non-invasif.',
                          style: TextStyleConstant.montserratNormal.copyWith(
                            color: ColorConstant.secondaryColor,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 56),
                  Text(
                    'Develop by',
                    style: TextStyleConstant.montserratNormal.copyWith(
                      color: ColorConstant.secondaryColor,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Image.asset(
                    'assets/icons/faeznz_logo.png',
                    width: 100,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
