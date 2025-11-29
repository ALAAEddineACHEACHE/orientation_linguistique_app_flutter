// lib/services/student_service.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/student.dart'; // ✅ Assurez-vous que le chemin est bon

class StudentService {
  // ✅ Champ privé déclaré ici
  final CollectionReference<Map<String, dynamic>> _studentsCollection =
      FirebaseFirestore.instance.collection('students');

  Future<void> createStudent({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );
      String uid = userCredential.user!.uid;

      await _studentsCollection.doc(uid).set({
        'name': name.trim(),
        'email': email.trim(),
        'phone': phone?.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw Exception('Cet email est déjà utilisé.');
      } else {
        throw Exception('Erreur: ${e.message}');
      }
    }
  }

  Stream<List<Student>> getAllStudents() {
    return _studentsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Student.fromMap(doc.id, doc.data()!);
      }).toList();
    });
  }

  // ✅ Méthode updateStudent
  Future<void> updateStudent(Student student) async {
    await _studentsCollection.doc(student.uid).update(student.toMap());
  }

  Future<void> deleteStudent(String uid) async {
    await _studentsCollection.doc(uid).delete();
  }
}