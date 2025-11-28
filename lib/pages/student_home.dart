import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'login_page.dart';
import 'quiz/quiz_page.dart';

class StudentHomePage extends StatelessWidget {
  const StudentHomePage({super.key});

  Future<void> _logout(BuildContext context) async {
    // Déconnexion Firebase
    await FirebaseAuth.instance.signOut();

    // Déconnexion Google
    final GoogleSignIn googleSignIn = GoogleSignIn();
    if (await googleSignIn.isSignedIn()) {
      await googleSignIn.signOut();
    }

    // Retour à la page de login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context), // Utilise la fonction
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Bienvenue étudiant 👋",
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10),
            const Text(
              "Quiz linguistique prêt !",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const QuizPage()),
                );
              },
              child: const Text("Commencer le Quiz"),
            ),
          ],
        ),
      ),
    );
  }
}
