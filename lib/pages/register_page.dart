import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kos_hunter/theme.dart';
import 'package:kos_hunter/pages/splash_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key}); // Praktik terbaik: tambahkan super.key

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool isLoading = false;

  Future<void> register() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final fullName = nameController.text.trim();
    final phone = phoneController.text.trim();

    if (email.isEmpty || password.isEmpty || fullName.isEmpty || phone.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Semua field harus diisi')),
        );
      }
      return;
    }

    setState(() => isLoading = true);

    try {
      final supabase = Supabase.instance.client;

      // ================== PERUBAHAN UTAMA DI SINI ==================
      // Kita sekarang mengirim 'full_name' dan 'phone' sebagai metadata
      // Pemicu di Supabase akan menangani sisanya.
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName,
          'phone': phone, // Kirim nomor telepon juga sebagai metadata
        },
      );
      // ==========================================================

      // Setelah mendaftar, langsung arahkan ke halaman berikutnya.
      // Kita tidak perlu lagi memeriksa user ID atau melakukan insert manual.
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SplashPage()),
        );
      }

    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal daftar: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // ... sisa kode build() Anda tidak perlu diubah, sudah bagus ...
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ListView(
            children: [
              const SizedBox(height: 40),
              Container(
                height: 70,
                width: 120,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/logo_new2.png'),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Create Account',
                style: blackTextStyle.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please register to continue',
                style: greyTextStyle.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 40),

              // Email
              buildInputField('Email', emailController),
              const SizedBox(height: 16),

              // Password
              buildInputField('Password', passwordController, isPassword: true),
              const SizedBox(height: 16),

              // Full Name
              buildInputField('Nama Lengkap', nameController),
              const SizedBox(height: 16),

              // Phone
              buildInputField('Nomor HP', phoneController, keyboardType: TextInputType.phone),
              const SizedBox(height: 20),

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
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'Register',
                          style: blueTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.pop(context),
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

  Widget buildInputField(String hint, TextEditingController controller,
      {bool isPassword = false, TextInputType keyboardType = TextInputType.text}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: blueColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        style: whiteTextStyle, // Menambahkan style agar teks input berwarna putih
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: whiteTextStyle,
        ),
      ),
    );
  }
}
