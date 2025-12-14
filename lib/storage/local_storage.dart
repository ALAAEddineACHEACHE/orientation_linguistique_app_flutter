import 'package:hive/hive.dart';

class LocalStorage {
  static final Box box = Hive.box('appBox');

  static void saveRole(String role) {
    box.put('role', role);
  }

  static String? getRole() {
    return box.get('role');
  }

  static void clear() {
    box.clear();
  }
}
