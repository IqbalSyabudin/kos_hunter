import 'package:flutter/material.dart';
import 'package:kos_hunter/theme.dart';
import 'package:kos_hunter/pages/login_page.dart';

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
