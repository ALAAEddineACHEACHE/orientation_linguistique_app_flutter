import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  final String uid; // ID Firebase Auth
  final String name;
  final String email;
  final String? phone;
  final DateTime createdAt;

  Student({
    required this.uid,
    required this.name,
    required this.email,
    this.phone,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'createdAt': createdAt,
    };
  }

  factory Student.fromMap(String uid, Map<String, dynamic> map) {
    return Student(
      uid: uid,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String?,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }
}