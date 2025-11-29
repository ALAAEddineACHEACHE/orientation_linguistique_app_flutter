import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../services/auth_service.dart';
import 'student_home.dart';
import 'admin_dashboard.dart';
import '../module/widget.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool isLoading = false;
  final AuthService _auth = AuthService();

  // ✅ GoogleSignIn avec clientId pour Web
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: "598730973278-51kurjt3pp0n0q82gruvqt12u2chqudq.apps.googleusercontent.com",
  );

  Future<void> login() async {
    setState(() => isLoading = true);

    String? role = await _auth.login(
      _username.text.trim(),
      _password.text.trim(),
    );

    setState(() => isLoading = false);

    if (role == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Invalid credentials")));
      return;
    }

    redirect(role);
  }

  Future<void> loginGoogle() async {
    setState(() => isLoading = true);

    String? role = await _auth.loginWithGoogle(_googleSignIn);

    setState(() => isLoading = false);

    if (role != null) {
      redirect(role);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Google login failed")),
      );
    }
  }

  Future<void> loginFacebook() async {
    String? role = await _auth.loginWithFacebook();
    if (role != null) redirect(role);
  }

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
                              ? const CircularProgressIndicator(color: Colors.white)
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

                      const SizedBox(height: 12),

                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: OutlinedButton.icon(
                          onPressed: loginFacebook,
                          icon: Image.asset('images/Facebook.png', width: 22),
                          label: const Text("Sign in with Facebook"),
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
