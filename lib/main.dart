import 'package:flutter/material.dart';
import 'package:kos_hunter/theme.dart';
import 'package:kos_hunter/pages/login_page.dart';
import 'package:kos_hunter/pages/register_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://ktckjunouqlspklltwej.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imt0Y2tqdW5vdXFsc3BrbGx0d2VqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTEyNjYyNzAsImV4cCI6MjA2Njg0MjI3MH0.hrDyI3laIvNyQlj36LDuBFAXbue0uVJZTz4hYQbPPvY',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
      },
    );
  }}
