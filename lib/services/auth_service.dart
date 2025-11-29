import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // LOGIN SIMPLE
  Future<String?> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    if (username == "student" && password == "123456") return "student";
    if (username == "admin" && password == "admin123") return "admin";
    return null;
  }

  // GOOGLE LOGIN (REAL OAUTH)
  Future<String?> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn(scopes: ["email"]).signIn();

      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential result =
          await _auth.signInWithCredential(credential);

      final String email = result.user?.email ?? "";

      return email.contains("admin") ? "admin" : "student";
    } catch (e) {
      print("GOOGLE ERROR: $e");
      return null;
    }
  }

  // FACEBOOK LOGIN (REAL OAUTH)
  Future<String?> loginWithFacebook() async {
    try {
      final LoginResult loginResult =
          await FacebookAuth.instance.login(permissions: ['email']);

      if (loginResult.status != LoginStatus.success) {
        return null;
      }

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      final UserCredential result =
          await _auth.signInWithCredential(facebookAuthCredential);

      final String email = result.user?.email ?? "";

      return email.contains("admin") ? "admin" : "student";
    } catch (e) {
      print("FACEBOOK ERROR: $e");
      return null;
    }
  }
}

  // ---- FACEBOOK (fake pour l'instant) ----
//   Future<String?> loginWithFacebook() async {
//     await Future.delayed(const Duration(seconds: 1));
//     return "student"; // temporaire jusqu'à vrai login Facebook
//   }
// }
