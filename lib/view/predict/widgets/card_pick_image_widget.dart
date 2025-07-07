import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:predict_anemia/constant/color_constant.dart';
import 'package:predict_anemia/constant/text_style_constant.dart';
import 'package:predict_anemia/view/predict/process_screen.dart';
import 'package:predict_anemia/view/predict/widgets/camera_popup_widget.dart';

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
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          Text(
            'Ayo cek kondisi kamu dengan mengambil gambar dari kamera atau galeri!',
            style: TextStyleConstant.montserratBold.copyWith(
              color: ColorConstant.secondaryColor,
              fontSize: 14,
            ),
          ),
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
                      "Upload foto telapak tangan kamu",
                      style: TextStyleConstant.montserratNormal.copyWith(
                        color: ColorConstant.whiteColor,
                        fontSize: 14,
                      ),
                    ),
                  const SizedBox(height: 20),
                  if (_imageFile == null)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              final imagePath = await showDialog<String>(
                                context: context,
                                builder: (context) => const CameraPopup(),
                              );
                              if (imagePath != null) {
                                setState(() {
                                  _imageFile = XFile(imagePath);
                                });
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                ColorConstant.whiteColor,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.camera,
                                    color: ColorConstant.primaryColor,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Ambil Gambar',
                                    style: TextStyleConstant.montserratBold
                                        .copyWith(
                                      fontSize: 16,
                                      color: ColorConstant.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              try {
                                final XFile? pickedFile = await _picker
                                    .pickImage(source: ImageSource.gallery);
                                setState(() {
                                  _imageFile = pickedFile;
                                });
                              } catch (_) {}
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                ColorConstant.whiteColor,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.image,
                                    color: ColorConstant.primaryColor,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Upload Gambar',
                                    style: TextStyleConstant.montserratBold
                                        .copyWith(
                                      fontSize: 16,
                                      color: ColorConstant.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                                  ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Silakan pilih gambar terlebih dahulu'),
                                ),
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
          Text(
            'Ikuti langkah berikut untuk mendapatkan hasil yang lebih baik',
            style: TextStyleConstant.montserratBold.copyWith(
              color: ColorConstant.primaryColor,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/ex-pict.png',
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tips Penggunaan:",
                      style: TextStyleConstant.montserratBold.copyWith(
                        fontSize: 14,
                        color: ColorConstant.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "- Pastikan telapak tangan memenuhi frame kamera dan pencahayaan cukup.",
                      style: TextStyleConstant.montserratNormal.copyWith(
                        fontSize: 14,
                        color: ColorConstant.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "- Jangan gunakan flash kamera!",
                      style: TextStyleConstant.montserratNormal.copyWith(
                        fontSize: 14,
                        color: ColorConstant.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "- Disarankan tidak melakukan zoom pada kamera.",
                      style: TextStyleConstant.montserratNormal.copyWith(
                        fontSize: 14,
                        color: ColorConstant.secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "*Untuk mendapatkan hasil yang lebih baik, ambil gambar diluar ruangan dengan cahaya natural.",
                      style: TextStyleConstant.montserratNormal.copyWith(
                        fontSize: 12,
                        color: ColorConstant.secondaryColor,
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
