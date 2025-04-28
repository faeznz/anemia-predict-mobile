import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:predict_anemia/constant/color_constant.dart';
import 'package:predict_anemia/constant/text_style_constant.dart';
import 'package:predict_anemia/view/login_register/account/account_screen.dart';
import 'package:predict_anemia/view/welcome/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeadingHomeWidget extends StatefulWidget {
  const HeadingHomeWidget({super.key});

  @override
  State<HeadingHomeWidget> createState() => _HeadingHomeWidgetState();
}

class _HeadingHomeWidgetState extends State<HeadingHomeWidget> {
  String? avatarUrl;

  @override
  void initState() {
    super.initState();
    _loadAvatarUrl();
  }

  // Mengambil avatarUrl dari SharedPreferences
  Future<void> _loadAvatarUrl() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      avatarUrl = prefs.getString('avatarUrl'); // Mendapatkan avatarUrl
    });
  }

  Future<void> _onProfileIconTap() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (!mounted) return;

    if (token != null && token.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AccountScreen()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Selamat Datang !',
              style: TextStyleConstant.montserratBold.copyWith(
                fontSize: 18,
              ),
            ),
            GestureDetector(
              onTap: _onProfileIconTap,
              child: avatarUrl != null && avatarUrl!.isNotEmpty
                  ? Container(
                      width: 40,
                      height: 40,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ColorConstant.primaryColor,
                          width: 2,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.network(
                          avatarUrl!,
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.person,
                              size: 30,
                              color: ColorConstant.primaryColor,
                            );
                          },
                        ),
                      ),
                    )
                  : FaIcon(
                      FontAwesomeIcons.circleUser,
                      color: ColorConstant.primaryColor,
                    ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        RichText(
          text: TextSpan(
            text: 'Ketahui kondisi kamu lewat aplikasi ini\n',
            style: TextStyleConstant.montserratBold.copyWith(
              color: ColorConstant.secondaryColor,
              fontSize: 24,
              height: 1.2,
            ),
            children: [
              TextSpan(
                text: 'Scan telapak tangan kamu untuk mengetahui hasilnya',
                style: TextStyleConstant.montserratNormal.copyWith(
                  color: ColorConstant.secondaryColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
