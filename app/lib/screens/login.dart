import 'package:flutter/material.dart';
class LoginScreen extends StatefulWidget { const LoginScreen({super.key}); @override State<LoginScreen> createState() => _LoginScreenState(); }
class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController(); final _pass = TextEditingController();
  void _login(){ Navigator.pushReplacementNamed(context, '/jobs'); }
  @override Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Padding(padding: const EdgeInsets.all(20.0), child: Column(mainAxisSize: MainAxisSize.min, children: [ const Text('GIGZ', style: TextStyle(fontSize:36,color: Color(0xFF0A47A1),fontWeight: FontWeight.bold)), const SizedBox(height:24), TextField(controller:_email, decoration: const InputDecoration(labelText:'Email')), const SizedBox(height:12), TextField(controller:_pass, decoration: const InputDecoration(labelText:'Password'), obscureText:true), const SizedBox(height:20), ElevatedButton(onPressed:_login, child: const Text('Login')) ])))); }
}
