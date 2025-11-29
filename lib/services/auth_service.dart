import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> login(String username, String password) async {
    // ✅ Admin simulé
    if (username == "admin" && password == "admin123") {
      return "admin";
    }

    // 🔁 Étudiant
    try {
      await _auth.signInWithEmailAndPassword(
        email: username.trim(),
        password: password.trim(),
      );
      return "student";
    } on FirebaseAuthException catch (e) {
      // ❌ Ne JAMAIS rethrow → retourner null
      return null;
    } catch (e) {
      // ⚠️ Autres erreurs (réseau, etc.)
      return null;
    }
  }

  Future<String?> loginWithGoogle(GoogleSignIn googleSignIn) async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      return "student";
    } catch (e) {
      return null;
    }
  }

  Future<String?> loginWithFacebook() async {
    return "student"; // simulé
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}