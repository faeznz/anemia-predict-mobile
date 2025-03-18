import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:predict_anemia/constant/color_constant.dart';
import 'package:predict_anemia/screen/predict/widgets/hasil_prediksi/connection_lost_result_widget.dart';
import 'package:predict_anemia/screen/predict/widgets/hasil_prediksi/good_result_widget.dart';
import 'package:predict_anemia/screen/predict/widgets/hasil_prediksi/warning_result_widget.dart';
import 'package:predict_anemia/screen/predict/widgets/header_process_image_widget.dart';

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

  @override
  void initState() {
    super.initState();
    _predictAnemia();
  }

  Future<void> _predictAnemia() async {
    final url = Uri.parse('http://10.0.2.2:8080/predict');
    final request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath(
        'file', widget.imagePath)); 

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final decodedResponse = jsonDecode(responseString);
        setState(() {
          _predictionResult = decodedResponse['prediction'];
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
