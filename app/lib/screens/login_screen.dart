import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _pass = TextEditingController();
  bool _loading = false;
  String? _error;

  Future<void> _login() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await AuthService.signInWithEmail(_email.text.trim(), _pass.text.trim());
      // After sign-in, navigate to jobs
      if (mounted) Navigator.pushReplacementNamed(context, '/jobs');
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Text('GIGZ',
                style: TextStyle(
                    fontSize: 36,
                    color: Color(0xFF0A47A1),
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email')),
            const SizedBox(height: 12),
            TextField(
                controller: _pass,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password')),
            const SizedBox(height: 20),
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loading ? null : _login,
                child: _loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Login'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A47A1)),
              ),
            ),
            TextButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const RegistrationPlaceholder())),
                child: const Text('Register (placeholder)'))
          ]),
        ),
      ),
    );
  }
}

class RegistrationPlaceholder extends StatelessWidget {
  const RegistrationPlaceholder({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Register')),
        body: const Center(
            child: Text('Implement registration flow (Firebase)')));
  }
}
