import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kos_hunter/theme.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final supabase = Supabase.instance.client;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool isLoading = false;
  bool isEditMode = false;

  String initialName = '';
  String initialPhone = '';

  @override
  void initState() {
    super.initState();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return;

    setState(() => isLoading = true);

    try {
      final response = await supabase
          .from('user_profile')
          .select()
          .eq('user_id', userId)
          .maybeSingle();

      if (response != null) {
        final name = response['full_name'] ?? '';
        final phone = response['phone'] ?? '';

        setState(() {
          nameController.text = name;
          phoneController.text = phone;
          initialName = name;
          initialPhone = phone;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat profil: $e')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> updateProfile() async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return;

    setState(() => isLoading = true);

    final profileData = {
      'user_id': userId,
      'full_name': nameController.text,
      'phone': phoneController.text,
      'updated_at': DateTime.now().toIso8601String(),
    };

    try {
      await supabase.from('user_profile').upsert(profileData);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profil berhasil diperbarui!')),
      );

      setState(() {
        isEditMode = false;
        initialName = nameController.text;
        initialPhone = phoneController.text;
      });
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan profil.')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  void cancelEdit() {
    setState(() {
      isEditMode = false;
      nameController.text = initialName;
      phoneController.text = initialPhone;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text(
          'Edit Profile',
          style: blackTextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: blackColor),
        actions: [
          if (!isLoading)
            IconButton(
              icon: Icon(
                isEditMode ? Icons.close : Icons.edit,
                color: blackColor,
              ),
              onPressed: () {
                if (isEditMode) {
                  cancelEdit();
                } else {
                  setState(() => isEditMode = true);
                }
              },
            ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Nama Lengkap'),
                    enabled: isEditMode,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: phoneController,
                    decoration: InputDecoration(labelText: 'Nomor HP'),
                    keyboardType: TextInputType.phone,
                    enabled: isEditMode,
                  ),
                  SizedBox(height: 40),
                  if (isEditMode)
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : updateProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: yellowGreenColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                                'Simpan Perubahan',
                                style: blueTextStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
