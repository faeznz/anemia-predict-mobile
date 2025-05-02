import 'package:flutter/material.dart';
import 'package:predict_anemia/constant/color_constant.dart';
import 'package:predict_anemia/constant/text_style_constant.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  Future<void> _launchURL() async {
    const url = 'https://faeznz-me.vercel.app/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Tidak dapat membuka URL: $url';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 5,
                decoration: BoxDecoration(
                  color: ColorConstant.primaryColor,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(24),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 24,
                    left: 44,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      Text(
                        'AnemiaPredict',
                        style: TextStyleConstant.montserratBlack.copyWith(
                          color: ColorConstant.whiteColor,
                        ),
                      ),
                      Text(
                        'Versi 1.3.0',
                        style: TextStyleConstant.montserratNormal.copyWith(
                          color: ColorConstant.whiteColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Visit me on Website',
                            style: TextStyleConstant.montserratBlack.copyWith(
                              color: ColorConstant.secondaryColor,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 12),
                          GestureDetector(
                            onTap: _launchURL,
                            child: Text(
                              'https://faeznz-me.vercel.app/',
                              style:
                                  TextStyleConstant.montserratNormal.copyWith(
                                color: ColorConstant.secondaryColor,
                                fontSize: 12,
                                decoration: TextDecoration.underline,
                              ),
                            ),
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
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
