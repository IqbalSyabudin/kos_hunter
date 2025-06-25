import 'package:flutter/material.dart';
import 'package:bwa_coyz/theme.dart';
import 'package:bwa_coyz/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(), // Ini akan jalan langsung ke LoginPage
    );
  }
}
