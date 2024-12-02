import 'package:flutter/material.dart';
import 'package:predict_anemia/constant/color_constant.dart';
import 'package:predict_anemia/constant/text_style_constant.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  // Data dummy riwayat
  final List<Map<String, dynamic>> _riwayatData = [
    {
      'tanggal': '1 Desember 2024 - 09:16',
      'hasil': 'Anda tidak terindikasi Anemia',
      'status': true, // true untuk tidak terindikasi, false untuk terindikasi
    },
    {
      'tanggal': '28 November 2024 - 20:46',
      'hasil': 'Anda terindikasi Anemia',
      'status': false,
    },
    {
      'tanggal': '28 Oktober 2024 - 13:19',
      'hasil': 'Anda tidak terindikasi Anemia',
      'status': true,
    },
    {
      'tanggal': '23 Mei 2024 - 23:05',
      'hasil': 'Anda tidak terindikasi Anemia',
      'status': true,
    },
    // Tambahkan data riwayat lainnya di sini
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Riwayat',
                  style: TextStyleConstant.montserratBlack.copyWith(
                    fontSize: 28,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: _riwayatData.length,
                  itemBuilder: (BuildContext context, int index) {
                    final riwayat = _riwayatData[index];
                    return ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: riwayat['status']
                              ? ColorConstant.secureColor
                              : ColorConstant.warningColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          riwayat['status'] ? Icons.check : Icons.warning,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        riwayat['tanggal'],
                        style: TextStyleConstant.montserratBold.copyWith(
                          color: ColorConstant.secondaryColor,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: Text(
                        riwayat['hasil'],
                        style: TextStyleConstant.montserratNormal.copyWith(
                          color: ColorConstant.secondaryColor,
                          fontSize: 12,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
