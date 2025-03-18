import 'package:flutter/material.dart';
import 'package:predict_anemia/constant/color_constant.dart';
import 'package:predict_anemia/constant/text_style_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Map<String, dynamic>> _riwayatData = [];
  bool _isLoading = true;
  bool _hasToken = false;
  Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    _checkTokenAndFetchData();
  }

  Future<void> _checkTokenAndFetchData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      _hasToken = true;
      await _fetchHistory(token); // Hanya mengirim token
    } else {
      _isLoading = false;
    }
    setState(() {});
  }

  Future<void> _fetchHistory(String token) async {
    try {
      final response = await _dio.get(
        'https://api-data-predict-anamia.vercel.app//history/email',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        _riwayatData = data.map((item) {
          return {
            'tanggal': DateFormat('dd MMMM yyyy - HH:mm')
                .format(DateTime.parse(item['datetime'])),
            'hasil': item['result'],
            'status': item['result'] == 'Tidak Anemia',
          };
        }).toList();
      } else {
        print('Failed to fetch history: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching history: $e');
    } finally {
      _isLoading = false;
      setState(() {});
    }
  }

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
              if (_isLoading)
                const CircularProgressIndicator()
              else if (!_hasToken)
                const Expanded(
                  child: Center(
                    child: Text('Login untuk melihat history'),
                  ),
                )
              else
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
