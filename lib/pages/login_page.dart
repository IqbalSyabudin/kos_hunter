import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kos_hunter/theme.dart';
import 'package:kos_hunter/pages/splash_page.dart';

class LoginPage extends StatelessWidget {
  // Tambahkan controller
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                'Welcome Back',
                style: blackTextStyle.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Please sign in to your account',
                style: greyTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 40),
              // Username TextField
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: blueColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  controller: usernameController, // pakai controller
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Username',
                    hintStyle: whiteTextStyle,
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Password TextField
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
              SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Password?',
                    style: greyTextStyle.copyWith(fontSize: 14),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Cek apakah username & password sudah diisi
                    if (usernameController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      // Kalau sudah diisi → Navigasi ke SplashPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SplashPage(),
                        ),
                      );
                    } else {
                      // Kalau kosong, kasih alert/snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Mohon isi Username dan Password'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: yellowGreenColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Sign In',
                    style: blueTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Tombol Google 
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    try {
                      final supabase = Supabase.instance.client;
                      await supabase.auth.signInWithOAuth(Provider.google);

                      final user = supabase.auth.currentUser;
                      if (user != null) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => SplashPage()),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Gagal login dengan Google: $e'),
                        ),
                      );
                    }
                  },
                  icon: Image.asset('assets/google.png', height: 24),
                  label: Text(
                    'Google',
                    style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text(
                  'Belum punya akun? Daftar di sini',
                  style: greyTextStyle.copyWith(fontSize: 14),
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Kosongkan jika belum ada login facebook
                  },
                  icon: Icon(Icons.facebook, color: Colors.white, size: 24),
                  label: Text(
                    'facebook',
                    style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1877F2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    side: BorderSide(color: Colors.blue.shade100, width: 1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
