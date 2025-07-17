import 'package:flutter/material.dart';
import 'package:kos_hunter/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final supabase = Supabase.instance.client;
  String fullName = '';
  String phone = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      setState(() {
        fullName = 'Tidak ada user';
        phone = '-';
        isLoading = false;
      });
      return;
    }

    try {
      final res = await supabase
          .from('user_profile')
          .select('full_name, phone')
          .eq('user_id', user.id)
          .maybeSingle();

      if (res == null) {
        // Jika belum ada data, insert otomatis
        await supabase.from('user_profile').insert({
          'user_id': user.id,
          'full_name': 'Nama belum diatur',
          'phone': 'Belum diisi',
        });

        fullName = 'Nama belum diatur';
        phone = 'Belum diisi';
      } else {
        fullName = res['full_name'] ?? 'Nama belum diatur';
        phone = res['phone'] ?? 'Belum diisi';
      }
    } catch (e) {
      fullName = 'Gagal ambil data';
      phone = '-';
      print('Error ambil profil: $e');
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Saya'),
        backgroundColor: purpleColor,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nama Lengkap:',
                      style: blackTextStyle.copyWith(fontSize: 16)),
                  SizedBox(height: 4),
                  Text(fullName, style: greyTextStyle.copyWith(fontSize: 20)),
                  SizedBox(height: 20),
                  Text('Nomor Telepon:',
                      style: blackTextStyle.copyWith(fontSize: 16)),
                  SizedBox(height: 4),
                  Text(phone, style: greyTextStyle.copyWith(fontSize: 20)),
                  SizedBox(height: 40),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => EditProfilePage()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: purpleColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text('Edit Profil',
                          style: whiteTextStyle.copyWith(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
