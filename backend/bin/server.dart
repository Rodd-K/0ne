import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:dotenv/dotenv.dart' show DotEnv;

void main() async {
  // Load environment variables
  final env = DotEnv()..load();
  final ip = InternetAddress.anyIPv4;
  final port =
      int.tryParse(Platform.environment['PORT'] ?? env['PORT'] ?? '8080') ??
          8080;

  final router = Router();

  // Routes
  router.get('/', (Request req) {
    return Response.ok(
      jsonEncode({'message': 'Welcome to GIGZ API (Dart)'}),
      headers: {'content-type': 'application/json'},
    );
  });

  router.get('/jobs', (Request req) {
    return Response.ok(
      jsonEncode([
        {'id': 1, 'title': 'Electrician', 'location': 'Nairobi'},
        {'id': 2, 'title': 'Plumber', 'location': 'Thika'}
      ]),
      headers: {'content-type': 'application/json'},
    );
  });

  // Start the server
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(router);
  final server = await io.serve(handler, ip, port);

  print('✅ Server running on http://${server.address.host}:${server.port}');
}
