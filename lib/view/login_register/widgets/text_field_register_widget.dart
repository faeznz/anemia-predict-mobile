import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:predict_anemia/constant/color_constant.dart';
import 'package:predict_anemia/constant/text_style_constant.dart';
import 'package:predict_anemia/model/user_model.dart';
import 'package:predict_anemia/view/login_register/login_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TextFieldRegisterWidget extends StatefulWidget {
  const TextFieldRegisterWidget({super.key});

  @override
  State<TextFieldRegisterWidget> createState() =>
      _TextFieldRegisterWidgetState();
}

class _TextFieldRegisterWidgetState extends State<TextFieldRegisterWidget> {
  bool _obscureText = true;
  String? _selectedGender;
  bool _isLoading = false; // Tambahkan variabel loading

  // Controllers for the text fields
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    _namaController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitData() async {
    // Get the values from the controllers and the dropdown
    final nama = _namaController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final jenisKelamin = _selectedGender;

    final userModel = UserModel(
      name: nama,
      email: email,
      password: password,
      gender: jenisKelamin,
    );

    setState(() {
      _isLoading = true; // Set loading ke true saat mengirim data
    });

    try {
      final dio = Dio();
      await dotenv.load();
      final baseUrl = dotenv.get('BASE_URL');
      final url = '$baseUrl/auth/register';

      // Replace with your actual API endpoint
      final response = await dio.post(
        url,
        data: userModel.toJson(),
      );

      if (!mounted) return;

      if (response.statusCode == 201) {
        // Registration successful
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful!')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      } else {
        // Registration failed
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration failed.')),
        );
      }
    } on DioException catch (e) {
      // Handle Dio errors
      print('Error during registration: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred.')),
      );
    } catch (e) {
      // Handle other errors
      print('Error during registration: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred.')),
      );
    } finally {
      setState(() {
        _isLoading = false; // Set loading ke false setelah selesai
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _namaController,
          style: TextStyleConstant.montserratNormal.copyWith(
            color: ColorConstant.secondaryColor,
            letterSpacing: 1,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            hintText: 'Nama',
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
          controller: _emailController,
          style: TextStyleConstant.montserratNormal.copyWith(
            color: ColorConstant.secondaryColor,
            letterSpacing: 1,
            fontSize: 16,
          ),
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
          style: TextStyleConstant.montserratNormal.copyWith(
            color: ColorConstant.secondaryColor,
            letterSpacing: 1,
            fontSize: 16,
          ),
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
        const SizedBox(height: 24),
        DropdownButtonFormField<String>(
          hint: Align(
            alignment: Alignment.center,
            child: Text(
              'Jenis Kelamin',
              style: TextStyleConstant.montserratNormal.copyWith(
                color: ColorConstant.secondaryColor,
                letterSpacing: 1,
                fontSize: 16,
              ),
            ),
          ),
          decoration: InputDecoration(
            hintText: 'Jenis Kelamin',
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
          value: _selectedGender,
          onChanged: (newValue) {
            setState(
              () {
                _selectedGender = newValue;
              },
            );
          },
          items:
              <String>['Laki-laki', 'Perempuan'].map<DropdownMenuItem<String>>(
            (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyleConstant.montserratNormal.copyWith(
                    color: ColorConstant.secondaryColor,
                    fontSize: 16,
                  ),
                ),
              );
            },
          ).toList(),
        ),
        const SizedBox(height: 40),
        SizedBox(
          width: double.infinity,
          child: _isLoading
              ? const Center(
                  child:
                      CircularProgressIndicator()) // Tampilkan loading indicator
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
                    'Daftar',
                    style: TextStyleConstant.montserratNormal.copyWith(
                      color: ColorConstant.whiteColor,
                      fontSize: 20,
                      letterSpacing: 1,
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
