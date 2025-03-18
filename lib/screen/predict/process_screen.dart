import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:predict_anemia/constant/color_constant.dart';
import 'package:predict_anemia/screen/predict/widgets/hasil_prediksi/connection_lost_result_widget.dart';
import 'package:predict_anemia/screen/predict/widgets/hasil_prediksi/good_result_widget.dart';
import 'package:predict_anemia/screen/predict/widgets/hasil_prediksi/warning_result_widget.dart';
import 'package:predict_anemia/screen/predict/widgets/header_process_image_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart'; // Import intl package

class ProcessScreen extends StatefulWidget {
  final String imagePath;
  final String? customApiIp;

  const ProcessScreen({
    super.key,
    required this.imagePath,
    this.customApiIp,
  });

  @override
  State<ProcessScreen> createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  String? _predictionResult;
  Dio _dio = Dio();
  String _apiIp = '10.0.2.2';

  @override
  void initState() {
    super.initState();
    if (widget.customApiIp != null) {
      _apiIp = widget.customApiIp!;
    }
    _processAndPredictAnemia();
  }

  Future<void> _processAndPredictAnemia() async {
    try {
      final croppedImagePath = await _cropImage(widget.imagePath);
      await _predictAnemia(croppedImagePath);
    } catch (e) {
      setState(() {
        _predictionResult = 'Error processing image';
      });
      print('Error processing image: $e');
    }
  }

  Future<String> _cropImage(String imagePath) async {
    final originalImage = img.decodeImage(File(imagePath).readAsBytesSync());

    if (originalImage != null) {
      final width = originalImage.width;
      final height = originalImage.height;
      final cropSize = (width < height ? width : height) * 0.8;

      final offsetX = (width - cropSize) ~/ 2;
      final offsetY = (height - cropSize) ~/ 2;

      final croppedImage = img.copyCrop(originalImage,
          x: offsetX,
          y: offsetY,
          width: cropSize.toInt(),
          height: cropSize.toInt());

      final appDir = await getApplicationDocumentsDirectory();
      final croppedImagePath =
          '${appDir.path}/${imagePath.split('/').last.split('.').first}_cropped.jpg';
      File(croppedImagePath).writeAsBytesSync(img.encodeJpg(croppedImage));

      return croppedImagePath;
    } else {
      throw Exception('Failed to decode image');
    }
  }

  Future<void> _predictAnemia(String imagePath) async {
    final url = Uri.parse('http://$_apiIp:8080/predict');
    final request = http.MultipartRequest('POST', url);

    // Kompres gambar sebelum dikirim
    List<int> compressedImageBytes = await _compressImage(imagePath);

    // Dapatkan datetime saat ini dalam format yang diinginkan
    String formattedDateTime =
        DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());

    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        compressedImageBytes,
        filename:
            'image_$formattedDateTime.jpg', // Gunakan datetime sebagai nama file
      ),
    );

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final decodedResponse = jsonDecode(responseString);
        setState(() {
          _predictionResult = decodedResponse['prediction'];
          _sendPredictionResult();
        });
      } else {
        setState(() {
          _predictionResult = 'Error connect to API';
        });
      }
    } catch (e) {
      setState(() {
        _predictionResult = 'Error connect to API';
      });
    }
  }

  Future<List<int>> _compressImage(String imagePath) async {
    final originalImage = img.decodeImage(File(imagePath).readAsBytesSync());

    if (originalImage != null) {
      // Kompres gambar dengan kualitas 80 (0-100)
      List<int> compressedBytes = img.encodeJpg(originalImage, quality: 60);
      return compressedBytes;
    } else {
      throw Exception('Failed to decode image for compression');
    }
  }

  Future<void> _sendPredictionResult() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      try {
        final response = await _dio.post(
          'https://api-data-predict-anamia.vercel.app/history',
          data: {'result': _predictionResult},
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        );

        if (response.statusCode == 201) {
          print('Prediction result sent successfully');
        } else {
          print('Failed to send prediction result: ${response.statusCode}');
        }
      } catch (e) {
        print('Error sending prediction result: $e');
      }
    } else {
      print('Token or email not found');
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
                                height: 400,
                                fit: BoxFit.cover,
                              ),
                            ] else if (_predictionResult == 'Tidak Anemia') ...[
                              const GoodResultWidget(),
                              Image.file(
                                File(widget.imagePath),
                                width: 300,
                                height: 400,
                                fit: BoxFit.cover,
                              ),
                            ] else ...[
                              const ConnectionLostResultWidget()
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
            )
          ],
        ),
      ),
    );
  }
}
