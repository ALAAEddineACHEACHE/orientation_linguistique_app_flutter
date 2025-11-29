import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 🔹 Login classique avec username/password
  Future<String?> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // simule un backend

    if (username == "student" && password == "123456") return "student";
    if (username == "admin" && password == "admin123") return "admin";

    return null; // credentials invalides
  }

  // 🔹 Login avec Google
  Future<String?> loginWithGoogle(GoogleSignIn googleSignIn) async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return null; // utilisateur annulé

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);

      // 🔹 Pour l’instant, on peut décider du rôle selon le mail
      final email = googleUser.email;
      if (email.endsWith("@admin.com")) { // exemple admin
        return "admin";
      } else {
        return "student";
      }
    } catch (e) {
      print("Google login error: $e");
      return null;
    }
  }
  Future<String?> loginWithFacebook() async {
    await Future.delayed(const Duration(seconds: 1));
    return "student"; 
  }

  // 🔹 Logout
  Future<void> logout() async {
    await _auth.signOut();
  }
}
