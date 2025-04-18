import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:predict_anemia/constant/color_constant.dart';
import 'package:predict_anemia/constant/text_style_constant.dart';
import 'package:predict_anemia/view/predict/process_screen.dart';

class CardPickImageWidget extends StatefulWidget {
  const CardPickImageWidget({super.key});

  @override
  State<CardPickImageWidget> createState() => _CardPickImageWidgetState();
}

class _CardPickImageWidgetState extends State<CardPickImageWidget> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  // String _customApiIp = '192.168.';

  Future<void> _openCamera() async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.camera);
      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          Text(
            'Pastikan telapak tangan kamu memenuhi frame kamera',
            style: TextStyleConstant.montserratBold.copyWith(
              color: ColorConstant.secondaryColor,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          //   child: TextFormField(
          //     initialValue: _customApiIp,
          //     decoration: InputDecoration(
          //       labelText: 'Custom API IP',
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(12),
          //       ),
          //     ),
          //     onChanged: (value) {
          //       setState(() {
          //         _customApiIp = value;
          //       });
          //     },
          //   ),
          // ),
          const SizedBox(height: 20),
          Container(
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
                  if (_imageFile != null)
                    Image.file(
                      File(_imageFile!.path),
                      width: 300,
                      height: 400,
                      fit: BoxFit.cover,
                    )
                  else
                    Text(
                      "Silahkan ambil gambar",
                      style: TextStyleConstant.montserratNormal.copyWith(
                        color: ColorConstant.whiteColor,
                        fontSize: 14,
                      ),
                    ),
                  const SizedBox(height: 20),
                  if (_imageFile == null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: _openCamera,
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              ColorConstant.whiteColor,
                            ),
                          ),
                          child: FaIcon(
                            FontAwesomeIcons.camera,
                            color: ColorConstant.primaryColor,
                          ),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              final XFile? pickedFile = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              setState(() {
                                _imageFile = pickedFile;
                              });
                            } catch (e) {
                              print("Error picking image: $e");
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              ColorConstant.whiteColor,
                            ),
                          ),
                          child: FaIcon(
                            FontAwesomeIcons.image,
                            color: ColorConstant.primaryColor,
                          ),
                        ),
                      ],
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _imageFile = null;
                            });
                          },
                          style: ButtonStyle(
                            shadowColor: WidgetStateColor.transparent,
                            backgroundColor: WidgetStatePropertyAll(
                              ColorConstant.primaryColor,
                            ),
                          ),
                          child: Text(
                            'Hapus',
                            style: TextStyleConstant.montserratBold.copyWith(
                              fontSize: 16,
                              color: ColorConstant.whiteColor,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_imageFile != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProcessScreen(
                                    imagePath: _imageFile!.path,
                                    // customApiIp:
                                    //     _customApiIp, // Kirim IP custom
                                  ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Silakan pilih gambar terlebih dahulu')),
                              );
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              ColorConstant.whiteColor,
                            ),
                          ),
                          child: Text(
                            'Analisis',
                            style: TextStyleConstant.montserratBold.copyWith(
                              fontSize: 16,
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/ex-pict.png',
                width: 150,
                height: 250,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Contoh Pengambilan Gambar",
                      style: TextStyleConstant.montserratBold.copyWith(
                        color: ColorConstant.primaryColor,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "Pastikan telapak tangan memenuhi frame kamera dan pencahayaan cukup. Jangan gunakan flash kamera!",
                      style: TextStyleConstant.montserratNormal.copyWith(
                        fontSize: 14,
                        color: ColorConstant.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
