import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;

  static User? get currentUser => _auth.currentUser;

  static Future<UserCredential> signInWithEmail(String email, String password) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> signOut() => _auth.signOut();

  // Get Firebase ID token for server verification
  static Future<String?> getIdToken() async {
    final u = _auth.currentUser;
    if (u == null) return null;
    return await u.getIdToken();
  }
}
