import 'package:flutter/foundation.dart';
import '../services/student_service.dart';
import '../models/student.dart';

class StudentProvider with ChangeNotifier {
  final StudentService _studentService = StudentService();

  bool _initialized = false;
  bool get initialized => _initialized;
  set initialized(bool value) => _initialized = value;

  List<Student> _students = [];
  List<Student> _allStudents = [];
  List<Student> get students => _students;

  void loadStudents() {
    _studentService.getAllStudents().listen((students) {
      _students = students;
      _allStudents = students;
      notifyListeners();
    });
  }
  void searchStudents(String query) {
    if (query.isEmpty) {
      _students = _allStudents;
    } else {
      final results = _allStudents.where((student) {
        final nameLower = student.name.toLowerCase();
        final emailLower = student.email.toLowerCase();
        final q = query.toLowerCase();
        return nameLower.contains(q) || emailLower.contains(q);
      }).toList();
      _students = results;
    }
    notifyListeners();
  }

  Future<void> addStudent({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) async {
    await _studentService.createStudent(
      name: name,
      email: email,
      password: password,
      phone: phone,
    );
  }
  Future<void> updateStudent(Student student) async {
  await _studentService.updateStudent(student);
}

  Future<void> deleteStudent(String uid) async {
    await _studentService.deleteStudent(uid);
  }
}