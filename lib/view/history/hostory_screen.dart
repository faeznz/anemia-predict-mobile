import 'package:flutter/material.dart';
import 'package:predict_anemia/constant/color_constant.dart';
import 'package:predict_anemia/constant/text_style_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Map<String, dynamic>> _riwayatData = [];
  bool _isLoading = true;
  bool _hasToken = false;
  final Dio _dio = Dio();

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
      await _fetchHistory(token);
    } else {
      _isLoading = false;
    }
    setState(() {});
  }

  Future<void> _fetchHistory(String token) async {
    int retryCount = 0;
    const maxRetries = 3;
    const retryDelay = Duration(seconds: 2);
    await dotenv.load();

    final baseUrl = dotenv.get('BASE_URL');
    final url = '$baseUrl/history';

    while (retryCount < maxRetries) {
      try {
        final response = await _dio.get(
          url,
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
                  .format(DateTime.parse(item['created_at'])),
              'hasil': item['result'],
              'status': item['result'] == 'Tidak Anemia',
            };
          }).toList();
          break;
        }
      } catch (e) {
        retryCount++;

        if (retryCount < maxRetries) {
          await Future.delayed(retryDelay);
        }
      }
    }

    _isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Riwayat',
                    style: TextStyleConstant.montserratBlack.copyWith(
                      fontSize: 28,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              if (_isLoading)
                const CircularProgressIndicator()
              else if (!_hasToken)
                Expanded(
                  child: Center(
                    child: Text(
                      'Data kamu kosong',
                      style: TextStyleConstant.montserratNormal.copyWith(
                        color: ColorConstant.secondaryColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                )
              else
                Expanded(
                  child: _riwayatData.isEmpty
                      ? Center(
                          child: Text(
                            'Data kamu kosong',
                            style: TextStyleConstant.montserratNormal.copyWith(
                              color: ColorConstant.secondaryColor,
                              fontSize: 14,
                            ),
                          ),
                        )
                      : ListView.builder(
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
                                  riwayat['status']
                                      ? Icons.check
                                      : Icons.warning,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(
                                riwayat['tanggal'],
                                style:
                                    TextStyleConstant.montserratBold.copyWith(
                                  color: ColorConstant.secondaryColor,
                                  fontSize: 14,
                                ),
                              ),
                              subtitle: Text(
                                riwayat['hasil'],
                                style:
                                    TextStyleConstant.montserratNormal.copyWith(
                                  color: ColorConstant.secondaryColor,
                                  fontSize: 12,
                                ),
                              ),
                            );
                          },
                        ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
