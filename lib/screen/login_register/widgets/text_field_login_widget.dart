import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:predict_anemia/bottom_navbar.dart';
import 'package:predict_anemia/constant/color_constant.dart';
import 'package:predict_anemia/constant/text_style_constant.dart';
import 'package:predict_anemia/model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TextFieldLoginWidget extends StatefulWidget {
  const TextFieldLoginWidget({super.key});

  @override
  State<TextFieldLoginWidget> createState() => _TextFieldLoginWidgetState();
}

class _TextFieldLoginWidgetState extends State<TextFieldLoginWidget> {
  bool _obscureText = true;

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

    try {
      // Create a Dio instance
      final dio = Dio();

      // Replace with your actual API endpoint
      final response = await dio.post(
        'http://10.0.2.2:4040/auth/login',
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
          SnackBar(content: Text('Login successful! Token: $token')),
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _emailController, // Add controller here
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
          controller: _passwordController, // Add controller here
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
          child: TextButton(
            onPressed: _submitData, // Call the _submitData function
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
