import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kos_hunter/theme.dart';
import 'package:kos_hunter/pages/splash_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> register() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email dan Password tidak boleh kosong')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final supabase = Supabase.instance.client;
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user != null) {
        // Daftar berhasil → ke SplashPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SplashPage()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal daftar: ${e.toString()}')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Container(
                height: 70,
                width: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/logo_new2.png'),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Create Account',
                style: blackTextStyle.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Please register to continue',
                style: greyTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 40),
              // Email Field
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: blueColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email',
                    hintStyle: whiteTextStyle,
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Password Field
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: blueColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Password',
                    hintStyle: whiteTextStyle,
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isLoading ? null : register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: yellowGreenColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'Register',
                          style: blueTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // kembali ke halaman login
                },
                child: Text(
                  'Sudah punya akun? Login di sini',
                  style: greyTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
