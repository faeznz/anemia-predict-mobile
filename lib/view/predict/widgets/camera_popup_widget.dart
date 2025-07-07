import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class CameraPopup extends StatefulWidget {
  const CameraPopup({super.key});

  @override
  State<CameraPopup> createState() => _CameraPopupState();
}

class _CameraPopupState extends State<CameraPopup> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.first;
    _controller = CameraController(
      frontCamera,
      ResolutionPreset.medium,
      enableAudio: false,
    );
    _initializeControllerFuture = _controller.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<String?> _takePicture() async {
    try {
      await _initializeControllerFuture;
      final tempDir = await getTemporaryDirectory();
      final filePath = path.join(tempDir.path, '${DateTime.now()}.png');
      await _controller.takePicture().then((XFile file) {
        file.saveTo(filePath);
      });
      return filePath;
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    const targetRatio = 3 / 4; // Rasio yang diinginkan untuk panduan

    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              alignment: Alignment.center,
              children: [
                // Kamera full screen dengan aspect ratio asli
                Center(
                  child: SizedBox(
                    width: screenSize.width,
                    height: screenSize.width / targetRatio, // Menyesuaikan 3:4
                    child: AspectRatio(
                      aspectRatio: targetRatio,
                      child: CameraPreview(_controller),
                    ),
                  ),
                ),

                // Overlay semi-transparan dengan lubang 3:4 di tengah
                Positioned.fill(
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5),
                      BlendMode.srcOut,
                    ),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            backgroundBlendMode: BlendMode.dstOut,
                          ),
                        ),
                        Center(
                          child: Container(
                            width: 300,
                            height: 300,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Center(
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                // Tombol
                Positioned(
                  bottom: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () async {
                      final imagePath = await _takePicture();
                      if (context.mounted) {
                        Navigator.pop(context, imagePath);
                      }
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text("Ambil Gambar"),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
