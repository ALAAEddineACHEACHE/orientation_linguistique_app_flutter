import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // ---- LOGIN SIMPLE (fake) ----
  Future<String?> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    if (username == "student" && password == "123456") {
      return "student";
    }
    if (username == "admin" && password == "admin123") {
      return "admin";
    }
    return null;
  }

  // ---- GOOGLE SIGN IN ----
  Future<String?> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return null;

      // Exemple : si email contient "admin"
      if (googleUser.email.contains("admin")) {
        return "admin";
      }
      return "student";
    } catch (e) {
      return null;
    }
  }

  // ---- FACEBOOK (fake pour l'instant) ----
  Future<String?> loginWithFacebook() async {
    await Future.delayed(const Duration(seconds: 1));
    return "student"; // tu changeras après la vraie intégration
  }
}
