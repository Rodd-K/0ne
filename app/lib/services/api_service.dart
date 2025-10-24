import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // For Android emulator use 10.0.2.2; change to your backend host for web/desktop
  static String base = 'http://10.0.2.2:8080';

  static Future<List<dynamic>> fetchJobs() async {
    final res = await http.get(Uri.parse('$base/jobs'));
    if (res.statusCode == 200) {
      // backend returns a JSON array
      return jsonDecode(res.body) as List<dynamic>;
    } else {
      throw Exception('Failed to load jobs (${res.statusCode})');
    }
  }

  // Example: POST STK push
  static Future<dynamic> stkPush(
      String phone, num amount, String accountRef) async {
    final res = await http.post(
      Uri.parse('$base/payments/stk-push'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {'phone': phone, 'amount': amount, 'account_ref': accountRef}),
    );
    return jsonDecode(res.body);
  }
}
