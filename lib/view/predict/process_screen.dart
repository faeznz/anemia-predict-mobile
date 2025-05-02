import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:predict_anemia/constant/color_constant.dart';
import 'package:predict_anemia/constant/text_style_constant.dart';
import 'package:predict_anemia/view/predict/widgets/button_result_widget.dart';
import 'package:predict_anemia/view/predict/widgets/hasil_prediksi/connection_lost_result_widget.dart';
import 'package:predict_anemia/view/predict/widgets/hasil_prediksi/good_result_widget.dart';
import 'package:predict_anemia/view/predict/widgets/hasil_prediksi/warning_result_widget.dart';
import 'package:predict_anemia/view/predict/widgets/header_process_image_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image/image.dart' as img;
import 'package:intl/intl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ProcessScreen extends StatefulWidget {
  final String imagePath;

  const ProcessScreen({
    super.key,
    required this.imagePath,
  });

  @override
  State<ProcessScreen> createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  String? _predictionResult;
  String? _predictionResultProbAnemia;
  String? _predictionResultProbNonAnemia;

  @override
  void initState() {
    super.initState();
    _processAndPredictAnemia();
  }

  Future<void> _processAndPredictAnemia() async {
    try {
      await _predictAnemia(widget.imagePath);
    } catch (e) {
      setState(() {
        _predictionResult = 'Error processing image';
      });
    }
  }

  Future<void> _predictAnemia(String imagePath) async {
    await dotenv.load();
    final predictUrl = dotenv.get('PREDICT_URL');
    final apiUrl = '$predictUrl/predict';
    final url = Uri.parse(apiUrl);
    final request = http.MultipartRequest('POST', url);

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    List<int> compressedImageBytes = await _compressImage(imagePath);

    String formattedDateTime =
        DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());

    request.files.add(
      http.MultipartFile.fromBytes(
        'image',
        compressedImageBytes,
        filename: 'image_$formattedDateTime.jpg',
      ),
    );

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final decodedResponse = jsonDecode(responseString);
        setState(() {
          _predictionResult = decodedResponse['prediction'];
          _predictionResultProbAnemia =
              (decodedResponse['probability']['anemia'] * 100)
                      .toStringAsFixed(2) +
                  '%';
          _predictionResultProbNonAnemia =
              (decodedResponse['probability']['tidak_anemia'] * 100)
                      .toStringAsFixed(2) +
                  '%';
        });
      } else {
        setState(() {
          _predictionResult = 'Error connecting to API';
        });
      }
    } catch (e) {
      setState(() {
        _predictionResult = 'Error connecting to API';
      });
    }
  }

  Future<List<int>> _compressImage(String imagePath) async {
    final imageBytes = await File(imagePath).readAsBytes();
    final originalImage = img.decodeImage(imageBytes);

    if (originalImage != null) {
      List<int> compressedBytes = img.encodeJpg(originalImage, quality: 30);
      return compressedBytes;
    } else {
      throw Exception('Failed to decode image for compression');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const HeaderProcessImageWidget(),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorConstant.primaryColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      if (_predictionResult != null)
                        Column(
                          children: [
                            if (_predictionResult == 'Anemia') ...[
                              const WarningResultWidget(),
                              Image.file(
                                File(widget.imagePath),
                                width: 300,
                                height: 300,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 16),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      'Probabilitas ',
                                      style: TextStyleConstant.montserratBold
                                          .copyWith(
                                        color: ColorConstant.whiteColor,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Anemia',
                                          style: TextStyleConstant
                                              .montserratNormal
                                              .copyWith(
                                            color: ColorConstant.whiteColor,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          _predictionResultProbAnemia ?? '-',
                                          style: TextStyleConstant
                                              .montserratNormal
                                              .copyWith(
                                            color: ColorConstant.whiteColor,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Tidak Anemia',
                                          style: TextStyleConstant
                                              .montserratNormal
                                              .copyWith(
                                            color: ColorConstant.whiteColor,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          _predictionResultProbNonAnemia ?? '-',
                                          style: TextStyleConstant
                                              .montserratNormal
                                              .copyWith(
                                            color: ColorConstant.whiteColor,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ] else if (_predictionResult == 'Tidak Anemia') ...[
                              const GoodResultWidget(),
                              Image.file(
                                File(widget.imagePath),
                                width: 300,
                                height: 300,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 16),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      'Probabilitas ',
                                      style: TextStyleConstant.montserratBold
                                          .copyWith(
                                        color: ColorConstant.whiteColor,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Anemia',
                                          style: TextStyleConstant
                                              .montserratNormal
                                              .copyWith(
                                            color: ColorConstant.whiteColor,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          _predictionResultProbAnemia ?? '-',
                                          style: TextStyleConstant
                                              .montserratNormal
                                              .copyWith(
                                            color: ColorConstant.whiteColor,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Tidak Anemia',
                                          style: TextStyleConstant
                                              .montserratNormal
                                              .copyWith(
                                            color: ColorConstant.whiteColor,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          _predictionResultProbNonAnemia ?? '-',
                                          style: TextStyleConstant
                                              .montserratNormal
                                              .copyWith(
                                            color: ColorConstant.whiteColor,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ] else ...[
                              const ConnectionLostResultWidget(),
                            ],
                          ],
                        )
                      else
                        CircularProgressIndicator(
                          color: ColorConstant.whiteColor,
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.all(32),
              child: ButtonResultWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
