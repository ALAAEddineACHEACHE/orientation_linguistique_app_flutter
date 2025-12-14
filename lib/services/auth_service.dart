import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Service responsable de toute la logique d’authentification
// - Login classique
// - Login Google (OAuth2)
// - Logout
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// 🔹 Login classique (simulation backend)
  /// Utilisé pour tests / démonstration académique
  Future<String?> login(String username, String password) async {
    // Simulation d’un appel serveur
    await Future.delayed(const Duration(seconds: 1));

    if (username == "student" && password == "123456") return "student";
    if (username == "admin" && password == "admin123") return "admin";

    // Retourne null si les identifiants sont incorrects
    return null;
  }

  //🔹 Login avec Google (OAuth2 via Firebase)
  // - Ouvre une fenêtre Google externe
  // - Authentifie l’utilisateur
  // - Retourne le rôle selon l’email
  Future<String?> loginWithGoogle(GoogleSignIn googleSignIn) async {
    try {
      // Démarrage du flow OAuth Google
      final GoogleSignInAccount? googleUser =
          await googleSignIn.signIn();

      // Cas où l’utilisateur annule la connexion
      if (googleUser == null) return null;

      // Récupération des tokens d’authentification
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Création du credential Firebase
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Connexion Firebase
      await _auth.signInWithCredential(credential);

      // Détermination du rôle (logique simplifiée)
      final email = googleUser.email;
      if (email.endsWith("@admin.com")) {
        return "admin";
      } else {
        return "student";
      }
    } catch (e) {
      // Log en cas d’erreur (utile en debug)
      print("Google login error: $e");
      return null;
    }
  }
  // 🔹 Déconnexion utilisateur
  Future<void> logout() async {
    await _auth.signOut();
  }
}
