import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:predict_anemia/constant/color_constant.dart';
import 'package:predict_anemia/constant/text_style_constant.dart';
import 'package:predict_anemia/view/login_register/account/widgets/button_logout_widget.dart';
import 'package:predict_anemia/view/login_register/account/widgets/header_account_widget.dart';
import 'package:predict_anemia/view/welcome/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String? name;
  String? email;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      // Token tidak ditemukan, redirect ke welcome
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      );
      return;
    }

    final response = await http.get(
      Uri.parse('http://10.0.2.2:4040/users/profile'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        name = data['name'];
        email = data['email'];
        isLoading = false;
      });
    } else {
      // Jika token invalid atau error lainnya, logout otomatis
      await prefs.remove('token');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderAccountWidget(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nama',
                          style: TextStyleConstant.montserratBold.copyWith(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          name ?? '',
                          style: TextStyleConstant.montserratNormal.copyWith(
                            fontSize: 20,
                            color: ColorConstant.secondaryColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Email',
                          style: TextStyleConstant.montserratBold.copyWith(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          email ?? '',
                          style: TextStyleConstant.montserratNormal.copyWith(
                            fontSize: 20,
                            color: ColorConstant.secondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.all(32),
                    child: ButtonLogoutWidget(),
                  ),
                ],
              ),
            ),
    );
  }
}
