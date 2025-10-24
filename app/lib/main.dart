import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login_screen.dart';
import 'screens/job_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const GigzApp());
}

class GigzApp extends StatelessWidget {
  const GigzApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GIGZ',
      theme: ThemeData(
        primaryColor: const Color(0xFF0A47A1),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0A47A1)),
        useMaterial3: false,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/jobs': (context) => const JobListScreen(),
      },
    );
  }
}
