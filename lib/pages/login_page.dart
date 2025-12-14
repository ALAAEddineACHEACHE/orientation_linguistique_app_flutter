import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth_service.dart';
import '../storage/local_storage.dart';
import '../module/widget.dart';
import 'student_home.dart';
import 'admin_dashboard.dart';

/// Page de connexion utilisateur
/// - Login classique
/// - Login Google
/// - Sauvegarde de session
/// - Redirection selon le rôle
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers champs texte
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool isLoading = false;

  final AuthService _auth = AuthService();

  // Google Sign-In (Web compatible)
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        "598730973278-51kurjt3pp0n0q82gruvqt12u2chqudq.apps.googleusercontent.com",
  );

  // -------------------- LOGIN CLASSIQUE --------------------
  Future<void> login() async {
    setState(() => isLoading = true);

    String? role = await _auth.login(
      _username.text.trim(),
      _password.text.trim(),
    );

    setState(() => isLoading = false);

    if (role == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid credentials")),
      );
      return;
    }

    await _handleLoginSuccess(role);
  }

  // -------------------- LOGIN GOOGLE --------------------
  Future<void> loginGoogle() async {
    setState(() => isLoading = true);

    String? role = await _auth.loginWithGoogle(_googleSignIn);

    setState(() => isLoading = false);

    if (role != null) {
      await _handleLoginSuccess(role);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Google login failed")),
      );
    }
  }

  // -------------------- POST-LOGIN --------------------
 Future<void> _handleLoginSuccess(String role) async {
  // 1️⃣ Hive : stockage persistant (rôle)
  // Si saveRole n'est pas async, on retire l'await
  LocalStorage.saveRole(role);

  // 2️⃣ SharedPreferences : état de session
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', true);
  await prefs.setString('role', role);

  // 3️⃣ Navigation UNIQUEMENT après succès complet
  if (!mounted) return;

  redirect(role);
}
  // -------------------- REDIRECTION --------------------
  void redirect(String role) {
    if (role == "admin") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AdminDashboard()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const StudentHomePage()),
      );
    }
  }

  // -------------------- UI --------------------
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[50],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/school.png', width: 100),
                const SizedBox(height: 20),

                Container(
                  width: 400,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[850] : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20,
                        color: Colors.black.withOpacity(0.1),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      EditBox(
                        hint: "username".tr(),
                        controller: _username,
                        prefixIcon: Icons.person_outline,
                      ),
                      EditBox(
                        hint: "password".tr(),
                        password: true,
                        controller: _password,
                        prefixIcon: Icons.lock_outline,
                      ),
                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : login,
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : Text("login".tr()),
                        ),
                      ),

                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey[400])),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text("OR"),
                          ),
                          Expanded(child: Divider(color: Colors.grey[400])),
                        ],
                      ),
                      const SizedBox(height: 15),

                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: OutlinedButton.icon(
                          onPressed: loginGoogle,
                          icon: Image.asset('images/Google.png', width: 22),
                          label: const Text("Sign in with Google"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
