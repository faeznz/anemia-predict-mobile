import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:predict_anemia/bottom_navbar.dart';
import 'package:predict_anemia/constant/color_constant.dart';
import 'package:predict_anemia/constant/text_style_constant.dart';
import 'package:predict_anemia/model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TextFieldLoginWidget extends StatefulWidget {
  const TextFieldLoginWidget({super.key});

  @override
  State<TextFieldLoginWidget> createState() => _TextFieldLoginWidgetState();
}

class _TextFieldLoginWidgetState extends State<TextFieldLoginWidget> {
  bool _obscureText = true;
  bool _isLoading = false; // Add loading variable

  // Controllers for the text fields
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitData() async {
    // Get the values from the controllers
    final email = _emailController.text;
    final password = _passwordController.text;
    final prefs = await SharedPreferences.getInstance();

    // Create a LoginModel instance
    final loginModel = LoginModel(
      email: email,
      password: password,
    );

    setState(() {
      _isLoading = true; // Set loading to true
    });

    try {
      // Create a Dio instance
      final dio = Dio();
      await dotenv.load();
      final baseUrl = dotenv.get('BASE_URL');
      final url = '$baseUrl/auth/login';

      // Replace with your actual API endpoint
      final response = await dio.post(
        url,
        data: loginModel.toJson(),
      );

      if (response.statusCode == 200) {
        final token = response.data['token'];

        await prefs.setString('token', token);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const MyButtomNavbar(),
          ),
          (Route<dynamic> route) => false,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login successful!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed.')),
        );
      }
    } on DioException catch (e) {
      // Handle Dio errors
      print('Error during login: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred.')),
      );
    } catch (e) {
      // Handle other errors
      print('Error during login: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred.')),
      );
    } finally {
      setState(() {
        _isLoading = false; // Set loading to false
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            hintText: 'Email',
            hintStyle: TextStyleConstant.montserratNormal.copyWith(
              color: ColorConstant.secondaryColor,
              letterSpacing: 1,
              fontSize: 16,
            ),
            filled: true,
            fillColor: ColorConstant.accentColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 24),
        TextField(
          controller: _passwordController,
          obscureText: _obscureText,
          decoration: InputDecoration(
            hintText: 'Password',
            hintStyle: TextStyleConstant.montserratNormal.copyWith(
              color: ColorConstant.secondaryColor,
              letterSpacing: 1,
              fontSize: 16,
            ),
            filled: true,
            fillColor: ColorConstant.accentColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 128),
        SizedBox(
          width: double.infinity,
          child: _isLoading
              ? const Center(
                  child:
                      CircularProgressIndicator()) // Display loading indicator
              : TextButton(
                  onPressed: _submitData,
                  style: TextButton.styleFrom(
                    backgroundColor: ColorConstant.primaryColor,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                    textStyle: TextStyleConstant.montserratNormal.copyWith(
                      color: ColorConstant.secondaryColor,
                      letterSpacing: 1,
                      fontSize: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Masuk',
                    style: TextStyleConstant.montserratNormal.copyWith(
                      color: ColorConstant.whiteColor,
                      fontSize: 20,
                      letterSpacing: 1,
                    ),
                  ),
                ),
        )
      ],
    );
  }
}
