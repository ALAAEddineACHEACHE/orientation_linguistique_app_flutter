import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../providers/student_provider.dart';
import '../models/student.dart';
import 'login_page.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      final google = GoogleSignIn();
      try {
        await google.disconnect();
      } catch (_) {}
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Déconnexion échouée : $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("admin_dashboard"),
        backgroundColor: Colors.indigo,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Consumer<StudentProvider>(
        builder: (context, provider, child) {
          if (!provider.initialized) {
            provider.loadStudents();
            provider.initialized = true;
          }

          final students = provider.students;
          final studentCount = students.length;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Stat card
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade50.withOpacity(isDark ? 0.2 : 1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.indigo.shade200, width: 1),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.indigo.shade100.withOpacity(isDark ? 0.3 : 1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.school, color: Colors.indigo, size: 28),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Étudiants inscrits",
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white70 : Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "$studentCount étudiants",
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Barre de recherche
                TextField(
                  decoration: InputDecoration(
                    hintText: "Rechercher un étudiant...",
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: isDark ? Colors.grey[850] : Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    provider.searchStudents(value);
                  },
                ),
                const SizedBox(height: 16),

                // Liste
                Expanded(
                  child: studentCount == 0
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.person_off, size: 64, color: Colors.grey),
                              SizedBox(height: 16),
                              Text("Aucun étudiant", style: TextStyle(fontSize: 18, color: Colors.grey)),
                              Text("Commencez par en ajouter un.", style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: studentCount,
                          itemBuilder: (context, index) {
                            final student = students[index];
                            return _buildStudentCard(context, student, isDark);
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addStudent(context),
        label: const Text("Ajouter un étudiant"),
        icon: const Icon(Icons.person_add),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildStudentCard(BuildContext context, Student student, bool isDark) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.indigo.shade100.withOpacity(isDark ? 0.4 : 1),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.indigo.shade300, width: 1),
              ),
              child: Center(
                child: Text(
                  student.name.isEmpty ? "?" : student.name[0].toUpperCase(),
                  style: TextStyle(
                    color: Colors.indigo.shade800,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    student.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    student.email,
                    style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600], fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (student.phone != null)
                    Text(
                      "📞 ${student.phone!}",
                      style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600], fontSize: 12),
                    ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => _editStudent(context, student),
                  splashRadius: 20,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteStudent(context, student.uid),
                  splashRadius: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _addStudent(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Ajouter un étudiant"),
          content: SizedBox(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: nameController, decoration: const InputDecoration(labelText: "Nom *")),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: "Email *"),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextField(controller: phoneController, decoration: const InputDecoration(labelText: "Téléphone (optionnel)")),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: "Mot de passe *"),
                  obscureText: true,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Annuler")),
            ElevatedButton(
              onPressed: () async {
                final name = nameController.text.trim();
                final email = emailController.text.trim();
                final password = passwordController.text.trim();

                if (name.isEmpty || email.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Veuillez remplir tous les champs obligatoires.")),
                  );
                  return;
                }

                if (password.length < 6) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Le mot de passe doit contenir au moins 6 caractères.")),
                  );
                  return;
                }

                try {
                  await Provider.of<StudentProvider>(context, listen: false).addStudent(
                    name: name,
                    email: email,
                    password: password,
                    phone: phoneController.text.trim().isEmpty ? null : phoneController.text.trim(),
                  );
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("✅ Étudiant créé avec succès !")),
                  );
                } catch (e) {
                  Navigator.pop(context);
                  String message = "❌ Erreur : ";
                  if (e.toString().contains("email-already-in-use")) {
                    message += "Cet email est déjà utilisé.";
                  } else if (e.toString().contains("invalid-email")) {
                    message += "Format d'email invalide.";
                  } else if (e.toString().contains("weak-password")) {
                    message += "Mot de passe trop faible.";
                  } else {
                    message += "Impossible de créer l'étudiant.";
                  }
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                }
              },
              child: const Text("Enregistrer"),
            ),
          ],
        );
      },
    );
  }

  void _editStudent(BuildContext context, Student student) {
    final nameController = TextEditingController(text: student.name);
    final emailController = TextEditingController(text: student.email);
    final phoneController = TextEditingController(text: student.phone ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Modifier l'étudiant"),
          content: SizedBox(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: nameController, decoration: const InputDecoration(labelText: "Nom")),
                TextField(controller: emailController, decoration: const InputDecoration(labelText: "Email")),
                TextField(controller: phoneController, decoration: const InputDecoration(labelText: "Téléphone (optionnel)")),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Annuler")),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.isEmpty || emailController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Nom et email requis")),
                  );
                  return;
                }

                final updatedStudent = Student(
                  uid: student.uid,
                  name: nameController.text.trim(),
                  email: emailController.text.trim(),
                  phone: phoneController.text.trim().isEmpty ? null : phoneController.text.trim(),
                  createdAt: student.createdAt,
                );

                try {
                  await Provider.of<StudentProvider>(context, listen: false).updateStudent(updatedStudent);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("✅ Mis à jour !")));
                } catch (e) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("❌ Erreur : $e")));
                }
              },
              child: const Text("Mettre à jour"),
            ),
          ],
        );
      },
    );
  }

  void _deleteStudent(BuildContext context, String uid) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Supprimer l’étudiant ?"),
          content: const Text("Cette action supprimera uniquement les données de l’étudiant."),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Annuler")),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () async {
                try {
                  await Provider.of<StudentProvider>(context, listen: false).deleteStudent(uid);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("✅ Étudiant supprimé.")),
                  );
                } catch (e) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("❌ Erreur : $e")),
                  );
                }
              },
              child: const Text("Supprimer", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}