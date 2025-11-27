import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Dashboard")),
      body: const Center(
        child: Text(
          "Bienvenue Admin 👑\nIci ton futur panel d'administration",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 23),
        ),
      ),
    );
  }
}
