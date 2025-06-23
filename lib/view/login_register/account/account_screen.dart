import 'package:flutter/material.dart';
import 'package:predict_anemia/constant/color_constant.dart';
import 'package:predict_anemia/constant/text_style_constant.dart';
import 'package:predict_anemia/view/login_register/account/widgets/button_logout_widget.dart';
import 'package:predict_anemia/view/login_register/account/widgets/header_account_widget.dart';
import 'package:predict_anemia/view/welcome/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String? name;
  String? email;
  String? gender;
  String? avatarUrl;
  bool isLoading = true;
  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    await dotenv.load();
    final baseUrl = dotenv.get('BASE_URL');
    final url = '$baseUrl/users/profile';

    if (!mounted) return;

    if (token == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      );
      return;
    }

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
        final data = response.data;
        await prefs.setString('avatarUrl', data['avatar_url']);
        setState(() {
          name = data['name'];
          email = data['email'];
          gender = data['gender'];
          avatarUrl = data['avatar_url'];
          isLoading = false;
        });
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        await prefs.remove('token');
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const WelcomeScreen()),
          );
        }
      } else {
        // Handle other Dio errors
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${e.message}')),
          );
        }
      }
    } catch (e) {
      // Handle generic errors
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unexpected error: $e')),
        );
      }
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
                        Center(
                          child: Column(
                            children: [
                              avatarUrl != null && avatarUrl!.isNotEmpty
                                  ? ClipOval(
                                      child: Image.network(
                                        avatarUrl!,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Icon(
                                            Icons.person,
                                            size: 40,
                                            color: ColorConstant.secondaryColor,
                                          );
                                        },
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          );
                                        },
                                      ),
                                    )
                                  : Text(
                                      ' ',
                                      style: TextStyleConstant.montserratNormal
                                          .copyWith(
                                        fontSize: 20,
                                        color: ColorConstant.secondaryColor,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
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
                        const SizedBox(height: 20),
                        Text(
                          'Gender',
                          style: TextStyleConstant.montserratBold.copyWith(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          gender ?? '-',
                          style: TextStyleConstant.montserratNormal.copyWith(
                            fontSize: 20,
                            color: ColorConstant.secondaryColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Password',
                          style: TextStyleConstant.montserratBold.copyWith(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '********',
                          style: TextStyleConstant.montserratNormal.copyWith(
                            fontSize: 20,
                            color: ColorConstant.secondaryColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.all(32),
                    child: Column(
                      children: [
                        // ButtonEditWidget(),
                        SizedBox(height: 8),
                        ButtonLogoutWidget(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
